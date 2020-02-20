#! /bin/sh

if [ "$1" = "--pull" ]; then
   git submodule foreach git pull
fi
docker-compose stop flask nginx
docker-compose rm -f flask nginx
docker rmi dockersecomp_flask:latest python:3-alpine nginx:alpine
sudo chown ubuntu:ubuntu -R volumes/db/data
docker-compose up --build  -d
