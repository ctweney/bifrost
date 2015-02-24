#!/bin/bash

echo "Starting application with RAILS_ENV=$RAILS_ENV"

cd /app
cp -n config/secrets.yml.example config/secrets.yml
bundle install

echo "Migrating database..."
bundle exec rake db:migrate

echo "Starting unicorn..."
bundle exec unicorn -p 3000
