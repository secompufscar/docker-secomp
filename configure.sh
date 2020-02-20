#!/bin/sh

# Caminho para o arquivo template do "nginx.conf"
NGINX_CONF_TEMPLATE_PATH="./volumes/nginx/nginx.conf.template"
# Caminho para o arquivo "nginx.conf"
NGINX_CONF_PATH="./volumes/nginx/nginx.conf"
# Camingo para o arquivo ".env"
DOT_ENV_PATH="./.env"

# Checando se foi passado --default, para utilizar os valores default
DEFAULT=0
if [ "$1" = "--default" ]; then
    DEFAULT=1
fi

SERVER_NAMES=default
if [ "$DEFAULT" = 0 ]; then
    # Caso não haja arg --default, lê a variável
    echo "> Entre SERVER_NAMES (localhost): " && read -r SERVER_NAMES
    if [ -z "$SERVER_NAMES" ]; then 
        SERVER_NAMES=localhost
    fi
fi

SERVER_DOMAIN=localhost
if [ "$DEFAULT" = 0 ]; then
   echo "> Entre SERVER_DOMAIN (localhost): " && read -r SERVER_DOMAIN
   if [ -z "$SERVER_DOMAIN" ]; then
      SERVER_DOMAIN=localhost 
   fi
fi

echo "Configurando Nginx"
# Criando arquivo de configurações
cp "$NGINX_CONF_TEMPLATE_PATH" "$NGINX_CONF_PATH"
# Substituindo váriaveis no template
sed --in-place "s/%(SERVER_NAMES)/$SERVER_NAMES/g" "$NGINX_CONF_PATH"
sed --in-place "s/%(SERVER_DOMAIN)/$SERVER_DOMAIN/g" "$NGINX_CONF_PATH"

echo "Configurando MySQL"
MYSQL_ROOT_PASSWORD="root"
if [ "$DEFAULT" = 0 ]; then
   echo "> Entre a senha do root (root): "
   stty -echo && read -r MYSQL_ROOT_PASSWORD 
   stty echo && echo 
   if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
      MYSQL_ROOT_PASSWORD="root"   
   fi
fi

MYSQL_DATABASE="db"
if [ "$DEFAULT" = 0 ]; then
   echo "- Entre o nome do banco de dados (db): " && read -r MYSQL_DATABASE
   if [ -z "$MYSQL_DATABASE" ]; then
      MYSQL_DATABASE="db"
   fi
fi

MYSQL_USER="root"
if [ "$DEFAULT" = 0 ]; then
   echo -n "- Entre o nome de usuário (root): " && read -r MYSQL_USER
   if [ -z "$MYSQL_USER" ]; then
      MYSQL_USER="root"
    fi
fi

MYSQL_PASSWORD="root"
if [ "$DEFAULT" = 0 ]; then
   echo "- Entre a senha do usuário (root): "
   stty -echo && read -r MYSQL_PASSWORD
   stty echo && echo
   if [ -z "$MYSQL_PASSWORD" ]; then
      MYSQL_PASSWORD="root"
    
   fi
fi

echo "Configurando ambiente do Flask"
FLASK_ENVIRONMENT="default"
if [ "$DEFAULT" = 0 ]; then
   echo "- Entre o nome do ambiente do Flask [development, production, default] (default): " && read -r FLASK_ENVIRONMENT
   if [ -z "$FLASK_ENVIRONMENT" ]; then
      FLASK_ENVIRONMENT="default"
   fi
fi

# Criando arquivo com váriaveis
echo "MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}" > "$DOT_ENV_PATH"
echo "MYSQL_DATABASE=${MYSQL_DATABASE}" >> "$DOT_ENV_PATH"
echo "MYSQL_USER=${MYSQL_USER}" >> "$DOT_ENV_PATH"
echo "MYSQL_PASSWORD=${MYSQL_PASSWORD}" >> "$DOT_ENV_PATH"
echo "FLASK_ENVIRONMENT=${FLASK_ENVIRONMENT}" >> "$DOT_ENV_PATH"
