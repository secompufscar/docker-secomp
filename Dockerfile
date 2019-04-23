FROM python:3-alpine

COPY ./site-secomp /site-secomp

WORKDIR /site-secomp

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000
CMD ["gunicorn", "-w 4", "-b :5000", "run.py"]
