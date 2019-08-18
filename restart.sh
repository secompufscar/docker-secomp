docker-compose stop flask nginx
docker-compose rm flask nginx
docker rmi dockersecomp_flask:latest python:3-alpine nginx:alpine
sudo chown ubuntu:ubuntu -R volumes/db/data
docker-compose up --build 
