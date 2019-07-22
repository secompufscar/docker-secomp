#! /bin/sh

echo "Checking if migration directory exists..."
if [ ! -d "/site-secomp/migrations" ]; then
   flask db init
fi

echo "Checking for schema updates..."
flask db migrate && flask db upgrade

echo "Starting up Gunicorn..."
exec gunicorn -w ${GUNICORN_WORKERS} -b :8000 app:'create_app()'
