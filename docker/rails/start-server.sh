#!/bin/bash

cd /app

# init the db only if needed
echo "Checking to see if database needs to be created..."
bundle exec rake database:create_if_necessary

echo "Migrating database..."
bundle exec rake db:migrate

echo "Starting unicorn with RAILS_ENV=$RAILS_ENV..."
bundle exec unicorn -p 3000
