#!/bin/sh
# wait-for-db.sh
set -e

HOST="db"
PORT="5432"

until pg_isready -h "$HOST" -p "$PORT" > /dev/null 2> /dev/null; do
  echo "Waiting for PostgreSQL at $HOST:$PORT..."
  sleep 1
done

exec "$@"
