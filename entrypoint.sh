#!/bin/sh

# Wait until the database is fully up and running
echo "Waiting for PostgreSQL at $DB_HOST:$DB_PORT..."

while ! nc -z $DB_HOST $DB_PORT; do
	sleep 0.1
done

echo "PostgreSQL started!"

# Run database migrations automatically
echo "Running migrations..."
python manage.py migrate --noinput

# Collect static files only if in production mode
if [ "$DEBUG" = "False" ]; then
	echo "Collecting static files (Production mode)..."
	python manage.py collectstatic --noinput
fi

# Execute the command specified in Dockerfile or Compose (e.g., Gunicorn/Runserver)
exec "$@"
