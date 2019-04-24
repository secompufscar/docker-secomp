FROM python:3-alpine

RUN  apk add --virtual build-deps gcc python3-dev musl-dev libffi-dev
RUN  rm -rf /var/cache/apk/*

COPY ./site-secomp /site-secomp

WORKDIR /site-secomp

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

ENV FLASK_CONFIGURATION default

ENTRYPOINT ["gunicorn", "-w", "4", "run:init"]
