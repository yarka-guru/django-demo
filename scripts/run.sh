#!/bin/bash
set -e

# Run the command
gunicorn -b :80 --chdir /app app.wsgi:application