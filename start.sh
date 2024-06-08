#!/bin/sh

set -e

echo "run db migration 05"
ls -lh /app
source /app/app.env
cat /app/app.env
echo $DB_SOURCE
/app/migrate -path /app/migration -database ${DB_SOURCE} -verbose up

echo "start the app"
exec "$@"