#! /bin/sh

echo "Checking if migration directory exists..."
if [ ! $(ls "/site-secomp/migrations") ]; then
	flask db init --directory /tmp/migrations
      	mv /tmp/migrations/* migrations/
fi

echo "Checking if database is up..."
if [ -n "$MYSQL_DATABASE" ]; then
	while ! mysqladmin ping -h 'db' -P '3306' --silent; do
		echo -n '.';
		sleep 2;	
	done
	echo "Database is up."
fi

echo "Performing schema migrations..."
flask db migrate && flask db upgrade

echo "Starting up Gunicorn..."
exec gunicorn -k gevent -w ${WORKERS:-4} -b ':8000' run:server
