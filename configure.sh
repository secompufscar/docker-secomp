#!/bin/bash

echo "Configurando o Docker"

echo "Configurando Nginx"
echo -n "- Entre SERVER_NAMES (localhost): "
read SERVER_NAMES
if [ -z $SERVER_NAMES ]
then
    SERVER_NAMES=localhost
fi

echo -n "- Entre SERVER_DOMAIN (localhost): "
read SERVER_DOMAIN
if [ -z $SERVER_DOMAIN ]
then
    SERVER_DOMAIN=localhost
fi

cp ./volumes/nginx/nginx.conf.template ./volumes/nginx/nginx.conf
sed --in-place "s/%(SERVER_NAMES)/$SERVER_NAMES/g" ./volumes/nginx/nginx.conf
sed --in-place "s/%(SERVER_DOMAIN)/$SERVER_DOMAIN/g" ./volumes/nginx/nginx.conf


echo "Configurando MySQL"

echo -n "- Entre a senha do root (root): "
read -s MYSQL_ROOT_PASSWORD 
echo
if [ -z $MYSQL_ROOT_PASSWORD ]
then
    MYSQL_ROOT_PASSWORD="root"
fi

echo -n "- Entre o nome do banco de dados (db): "
read MYSQL_DATABASE 
if [ -z $MYSQL_DATABASE ]
then
    MYSQL_DATABASE="db"
fi

echo -n "- Entre o nome de usuário (root): "
read MYSQL_USER
if [ -z $MYSQL_USER ]
then
    MYSQL_USER="root"
fi

echo -n "- Entre a senha (root): "
read -s MYSQL_PASSWORD
echo
if [ -z $MYSQL_PASSWORD ]
then
    MYSQL_PASSWORD="root"
fi

echo "Configurando ambiente do Flask"
echo -n "- Entre o nome do ambiente do Flask [development, production, default] (development): "
read FLASK_ENVIRONMENT
if [ -z $FLASK_ENVIRONMENT ]
then
    FLASK_ENVIRONMENT="development"
fi

echo "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" > .env
echo "MYSQL_DATABASE=$MYSQL_DATABASE" >> .env
echo "MYSQL_USER=$MYSQL_USER" >> .env
echo "MYSQL_PASSWORD=$MYSQL_PASSWORD" >> .env
echo "FLASK_ENVIRONMENT=$FLASK_ENVIRONMENT" >> .env
