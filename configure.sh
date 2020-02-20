#!/bin/sh

# Caminho para o arquivo template do "nginx.conf"
NGINX_CONF_TEMPLATE_PATH="./volumes/nginx/nginx.conf.template"
# Caminho para o arquivo "nginx.conf"
NGINX_CONF_PATH="./volumes/nginx/nginx.conf"
# Camingo para o arquivo ".env"
DOT_ENV_PATH="./.env"

# Checando se foi passado --default, para utilizar os valores default
DEFAULT=0
if [ "$1" = "--default" ]
then
    DEFAULT=1
fi

echo "Configurando o Docker"

echo "Configurando Nginx"

# Caso nao foi passado --default
if [ $DEFAULT = 0 ]
then
    # Caso variavel ja esteja setada, nao realizar o read.
    if [ -z $SERVER_NAMES ]
    then
        echo -n "- Entre SERVER_NAMES (localhost): "
        read SERVER_NAMES
    
        if [ -z $SERVER_NAMES ]
        then
            SERVER_NAMES=localhost
    
        fi
    fi
else
    SERVER_NAMES=localhost
fi

if [ $DEFAULT = 0 ]
then
    if [ -z $SERVER_DOMAIN ]
    then
        echo -n "- Entre SERVER_DOMAIN (localhost): "
        read SERVER_DOMAIN
    
        if [ -z $SERVER_DOMAIN ]
        then
            SERVER_DOMAIN=localhost
    
        fi
    fi
else
    SERVER_DOMAIN=localhost
fi

# Criando arquivo de configurações
cp $NGINX_CONF_TEMPLATE_PATH $NGINX_CONF_PATH
# Substituindo váriaveis no template
sed --in-place "s/%(SERVER_NAMES)/$SERVER_NAMES/g" $NGINX_CONF_PATH
sed --in-place "s/%(SERVER_DOMAIN)/$SERVER_DOMAIN/g" $NGINX_CONF_PATH


echo "Configurando MySQL"

if [ $DEFAULT = 0 ]
then
    if [ -z $MYSQL_ROOT_PASSWORD ]
    then
        echo -n "- Entre a senha do root (root): "
        stty -echo
        read MYSQL_ROOT_PASSWORD 
        stty echo
        echo
    
        if [ -z $MYSQL_ROOT_PASSWORD ]
        then
            MYSQL_ROOT_PASSWORD="root"
    
        fi
    fi
else
    MYSQL_ROOT_PASSWORD="root"
fi

if [ $DEFAULT = 0 ]
then
    if [ -z $MYSQL_DATABASE ]
    then
        echo -n "- Entre o nome do banco de dados (db): "
        read MYSQL_DATABASE
    
        if [ -z $MYSQL_DATABASE ]
        then
            MYSQL_DATABASE="db"
    
        fi
    fi
else
    MYSQL_DATABASE="db"
fi

if [ $DEFAULT = 0 ]
then
    if [ -z $MYSQL_USER ]
    then
        echo -n "- Entre o nome de usuário (root): "
        read MYSQL_USER
    
        if [ -z $MYSQL_USER ]
        then
            MYSQL_USER="root"
    
        fi
    fi
else
    MYSQL_USER="root"
fi

if [ $DEFAULT = 0 ]
then
    if [ -z $MYSQL_PASSWORD ]
    then
        echo -n "- Entre a senha do usuário (root): "
        stty -echo
        read MYSQL_PASSWORD
        stty echo
        echo
    
        if [ -z $MYSQL_PASSWORD ]
        then
            MYSQL_PASSWORD="root"
    
        fi
    fi
else
    MYSQL_PASSWORD="root"
fi

if [ $DEFAULT = 0 ]
then
    if [ -z $FLASK_ENVIRONMENT ]
    then
        echo "Configurando ambiente do Flask"
        echo -n "- Entre o nome do ambiente do Flask [development, production, default] (default): "
        read FLASK_ENVIRONMENT
    
        if [ -z $FLASK_ENVIRONMENT ]
        then
            FLASK_ENVIRONMENT="default"

        fi
    fi
else
    FLASK_ENVIRONMENT="default"
fi

# Criando arquivo com váriaveis
echo "MYSQL_ROOT_PASSWORD=\"$MYSQL_ROOT_PASSWORD\"" > $DOT_ENV_PATH
echo "MYSQL_DATABASE=\"$MYSQL_DATABASE\"" >> $DOT_ENV_PATH
echo "MYSQL_USER=\"$MYSQL_USER\"" >> $DOT_ENV_PATH
echo "MYSQL_PASSWORD=\"$MYSQL_PASSWORD\"" >> $DOT_ENV_PATH
echo "FLASK_ENVIRONMENT=\"$FLASK_ENVIRONMENT\"" >> $DOT_ENV_PATH
