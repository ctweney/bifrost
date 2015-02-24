#!/bin/bash

RAILS_ENV=$1
if [ -z $RAILS_ENV ]; then
  RAILS_ENV="production"
fi

echo "Restarting rails container with RAILS_ENV=$RAILS_ENV"

docker stop rails
docker rm rails
docker run -e "RAILS_ENV=$RAILS_ENV" -d -p 3000:3000 -v /app:/app --link postgres:db --name rails rails:latest