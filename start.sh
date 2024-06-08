#!/bin/sh

set -e

echo "run db migration 06"
echo "ls /app ----"
ls -lh /app
echo " ----"
source /app/app.env

echo "tail -n 1000 /app/app.env ----"
tail -n 1000 /app/app.env
echo $DB_SOURCE

echo "ls /app/migration ----"
ls -lh /app/migration
echo " ----"

/app/migrate -path /app/migration -database ${DB_SOURCE} -verbose up

echo "start the app"
exec "$@"