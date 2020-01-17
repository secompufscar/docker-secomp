FROM alpine:latest

COPY ./backup.sh /etc/periodic/weekly

RUN apk update && \
    apk upgrade && \
    apk add --no-cache mariadb-client && \
    chmod a+x /etc/periodic/weekly/*
