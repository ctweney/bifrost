#!/bin/bash

echo "Starting application with RAILS_ENV=$RAILS_ENV"

cd /app
cp -n config/secrets.yml.example config/secrets.yml
bundle install

# init the db only if needed
echo "Checking to see if database needs to be created..."
bundle exec rake database:create_if_necessary

echo "Compiling assets..."
bundle exec rake assets:precompile

echo "Migrating database..."
bundle exec rake db:migrate

echo "Starting unicorn..."
bundle exec unicorn -p 3000
