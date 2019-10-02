#! /bin/sh

PATH=/bin:"$PATH"

echo "Checking if migration directory exists..."
if [ ! $(ls "/site-secomp/migrations") ]; then
   flask db init --directory /tmp/migrations
   mv /tmp/migrations/* migrations/
fi

echo "Checking for schema updates..."
flask db migrate && flask db upgrade

echo "Starting up Gunicorn..."
exec gunicorn -k gevent -w ${GUNICORN_WORKERS} -b :8000 app:'create_app()'
