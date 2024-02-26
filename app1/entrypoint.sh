#!/bin/bash

rm /app/tmp/pids/server.pid

bundle install && bundle exec rake db:create && bundle exec rake db:migrate

exec "$@"
