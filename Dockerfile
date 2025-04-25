# Dockerfile for Django + DRF + PostgreSQL
FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /code

COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

RUN apt-get update && apt-get install -y postgresql-client \
    && rm -rf /var/lib/apt/lists/*

COPY . .

# Add a script to wait for the db before running Django commands
COPY wait-for-db.sh /wait-for-db.sh
RUN chmod +x /wait-for-db.sh

# Use runserver for dev, gunicorn for prod based on DJANGO_DEV env var
CMD ["/wait-for-db.sh", "sh", "-c", "if [ '$DJANGO_DEV' = 'true' ]; then python manage.py runserver 0.0.0.0:8000; else gunicorn simple_api.wsgi:application --bind 0.0.0.0:8000; fi"]
