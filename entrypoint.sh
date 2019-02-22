#!/bin/sh

echo "Waiting for postgres..."

while ! nc -z discuss_db 5432; do
    sleep 0.1
done

echo "PostgreSQL started"

mix do ecto.create, ecto.migrate, phoenix.server