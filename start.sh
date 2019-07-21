#! /bin/sh

echo "Checking for schema updates..."
flask db migrate && flask db upgrade 
echo "Starting up Gunicorn..."
exec gunicorn -w ${GUNICORN_WORKERS} -b :8000 app:'create_app()'
