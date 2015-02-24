#!/bin/bash

RAILS_ENV=$1
if [ -z $RAILS_ENV ]; then
  RAILS_ENV="production"
fi

echo "Running rails console with RAILS_ENV=$RAILS_ENV"

docker run -e "RAILS_ENV=$RAILS_ENV" -i -t -v /app:/app --link postgres:db  --rm rails:latest bash -c "cd /app && bundle exec rails c"