#!/bin/sh

set -e

if [-f tmp/pids/server.pid]; then
  rm tmp/pids/server.pid
fi

bin/rails db:migrate

exec "$@"