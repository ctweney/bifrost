#!/bin/bash
cd /app
cp -n secrets.yml.example secrets.yml
bundle install
bundle exec unicorn -p 3000