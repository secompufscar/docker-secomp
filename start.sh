#! /bin/sh

echo "Starting up Gunicorn..."
exec gunicorn -w ${GUNICORN_WORKERS} app:'create_app()'
