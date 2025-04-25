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

CMD ["/wait-for-db.sh", "python", "manage.py", "runserver", "0.0.0.0:8000"]
