FROM python:3-alpine

RUN  apk add --no-cache --virtual build-deps gcc musl-dev libffi-dev

COPY ./site-secomp /site-secomp
WORKDIR /site-secomp

RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir requests

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
