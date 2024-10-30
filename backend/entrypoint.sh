#!/bin/sh
# Run Django migrations
python manage.py migrate

# Start Gunicorn server for production
exec gunicorn backend.wsgi:application --bind 0.0.0.0:8000

