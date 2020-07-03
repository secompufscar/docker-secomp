# docker-secomp
Dockerfiles usadas na infraestrutura da SECOMP

## Instalação
Para rodar o projeto é necessário instalar as seguintes dependências:
- docker
- docker-compose

E adicionar o seu usuário ao grupo `docker`
```bash
# sudo usermod -aG docker $USER
```

## Configuração
### Docker
Crie um arquivo .env na raiz do projeto com as seguintes variáveis declaradas:
```bash
MYSQL_ROOT_PASSWORD=<senha do usuário root>
MYSQL_DATABASE=<nome do banco de dados>
MYSQL_USER=<nome do usuário do flask>
MYSQL_PASSWORD=<senha do usuário do flask>
FLASK_ENVIRONMENT=<ambiente do flask [development, production, default]>
```
### Flask
Preencha as variáveis necessárias no arquivo `<FLASK_ENVIRONMENT>.py` assim como descritas no [projeto](https://github.com/secompufscar/site-secomp).

## Nginx
Declare duas variáveis para configuração do arquivo `volumes/nginx.conf` e então edite o arquivo:
```bash
# export SERVER_NAMES=<Links por onde o site pode ser acessado>
# export SERVER_DOMAIN=<Domínio do site para qual o certificado foi assinado>
# sed "s/%(SERVER_NAMES)/$SERVER_NAMES/g" nginx.conf --in-place
# sed "s/%(SERVER_DOMAIN)/$SERVER_DOMAIN/g" nginx.conf --in-place
```

## Certbot
Declare a variável `OWNER_EMAIL` e então edite o arquivo `init-letsencrypt.sh`:
```bash
# sed "s/%(OWNER_EMAIL)/$OWNER_EMAIL/g" init-letsencrypt.sh --in-place
# ./init-letsencrypt.sh
```
Siga as instruções para criação do certificado e configuração do Certbot.




