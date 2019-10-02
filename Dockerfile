FROM python:3-alpine as builder
WORKDIR /build

COPY ./site-secomp/requirements.txt /requirements.txt
RUN apk add --no-cache --virtual build-deps gcc musl-dev zlib-dev jpeg-dev libffi-dev openssl-dev && \
    pip install --install-option="--prefix=/build" -r /requirements.txt && \
    apk del build-deps

FROM python:3-alpine as runner
WORKDIR /site-secomp

RUN apk add --no-cache zlib-dev jpeg-dev

COPY --from=builder /build /usr/local
COPY ./site-secomp ./

RUN apk add --no-cache zlib-dev jpeg-dev libmagic

ENV PATH /usr/local/bin:$PATH \
    FLASK_CONFIGURATION default \
    GUNICORN_WORKERS 4

EXPOSE 8000

COPY healthcheck.py ./
HEALTHCHECK --start-period=30s \
        CMD python healthcheck.py || exit 1

COPY start.sh ./

CMD ["./start.sh"]
