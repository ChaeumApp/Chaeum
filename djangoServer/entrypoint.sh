#!/bin/sh

# Apply database migrations
echo "Apply database migrations"
exec python manage.py migrate

# Start server
echo "Starting server"
exec python manage.py runserver 0:8000