#!/bin/sh

# Caminho para o arquivo template do "nginx.conf"
NGINX_CONF_TEMPLATE_PATH="./volumes/nginx/nginx.conf.template"
# Caminho para o arquivo "nginx.conf"
NGINX_CONF_PATH="./volumes/nginx/nginx.conf"
# Camingo para o arquivo ".env"
DOT_ENV_PATH="./.env"

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

# Criando arquivo de configurações
cp $NGINX_CONF_TEMPLATE_PATH $NGINX_CONF_PATH
# Substituindo váriaveis no template
sed --in-place "s/%(SERVER_NAMES)/$SERVER_NAMES/g" $NGINX_CONF_PATH
sed --in-place "s/%(SERVER_DOMAIN)/$SERVER_DOMAIN/g" $NGINX_CONF_PATH


echo "Configurando MySQL"

echo -n "- Entre a senha do root (root): "
stty -echo
read MYSQL_ROOT_PASSWORD 
stty echo
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

echo -n "- Entre a senha do usuário (root): "
stty -echo
read MYSQL_PASSWORD
stty echo
echo
if [ -z $MYSQL_PASSWORD ]
then
    MYSQL_PASSWORD="root"
fi

echo "Configurando ambiente do Flask"
echo -n "- Entre o nome do ambiente do Flask [development, production, default] (default): "
read FLASK_ENVIRONMENT
if [ -z $FLASK_ENVIRONMENT ]
then
    FLASK_ENVIRONMENT="default"
fi

# Criando arquivo com váriaveis
echo "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" > $DOT_ENV_PATH
echo "MYSQL_DATABASE=$MYSQL_DATABASE" >> $DOT_ENV_PATH
echo "MYSQL_USER=$MYSQL_USER" >> $DOT_ENV_PATH
echo "MYSQL_PASSWORD=$MYSQL_PASSWORD" >> $DOT_ENV_PATH
echo "FLASK_ENVIRONMENT=$FLASK_ENVIRONMENT" >> $DOT_ENV_PATH
