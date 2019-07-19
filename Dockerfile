FROM python:3-alpine as builder

RUN mkdir /build \
	&& apk add --no-cache --virtual build-deps gcc musl-dev libffi-dev openssl-dev
WORKDIR /build
COPY ./site-secomp/requirements.txt /requirements.txt
RUN pip install --install-option="--prefix=/build" -r /requirements.txt

FROM python:3-alpine as runner

COPY --from=builder /build /usr/local
COPY ./site-secomp /site-secomp
WORKDIR /site-secomp

ENV PATH /usr/local/bin:$PATH
ENV FLASK_CONFIGURATION default
ENV GUNICORN_WORKERS 4

EXPOSE 8000

COPY healthcheck.py ./
HEALTHCHECK --start-period=30s \
        CMD python healthcheck.py || exit 1

COPY start.sh ./
RUN chmod +x ./start.sh

CMD ["./start.sh"]
