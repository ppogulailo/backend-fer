#!/bin/sh
set -e

if [ "$SKIP_MIGRATE" != "1" ] && [ -n "$DATABASE_URL" ]; then
  echo "Running database migrations..."
  npx prisma migrate deploy
fi

exec "$@"
