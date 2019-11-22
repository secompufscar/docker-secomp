FROM python:3-alpine as builder
WORKDIR /build

COPY ./site-secomp/requirements.txt .
RUN apk update && \
    apk add --no-cache --virtual build-deps gcc musl-dev zlib-dev jpeg-dev libffi-dev openssl-dev && \
    pip wheel --wheel-dir=/opt/wheels -r requirements.txt

FROM python:3-alpine as runner
WORKDIR /site-secomp

COPY --from=builder /opt/wheels /opt/wheels
COPY ./site-secomp .

RUN apk add --no-cache zlib-dev jpeg-dev libmagic binutils musl-dev tzdata mysql-client && \
    pip install --no-index --find-links=/opt/wheels -r requirements.txt

ENV FLASK_CONFIGURATION=default \
    WORKERS=4 \
    TZ=America/Sao_Paulo

EXPOSE 8000

COPY healthcheck.py .
HEALTHCHECK --start-period=30s \
        CMD python healthcheck.py || exit 1

COPY flask_entrypoint.sh .

ENTRYPOINT ["./flask_entrypoint.sh"]
