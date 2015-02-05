#!/bin/bash
cd /app
cp -n config/secrets.yml.example config/secrets.yml
bundle install
bundle exec unicorn -p 3000