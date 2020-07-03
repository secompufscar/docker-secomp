FROM python:3-slim as builder
WORKDIR /build

COPY ./site-secomp/requirements.txt .
RUN apt update && \
    apt install -y zlib1g-dev libjpeg-dev libffi-dev openssl && \
    pip wheel --wheel-dir=/opt/wheels -r requirements.txt

FROM python:3-slim as runner
WORKDIR /site-secomp

COPY --from=builder /opt/wheels /opt/wheels
COPY ./site-secomp .

RUN apt update && \
    apt install -y zlib1g-dev libjpeg-dev libmagic1 binutils tzdata default-mysql-client && \
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
