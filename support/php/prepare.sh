#!/usr/bin/env bash

set -e

bin/healthcheck 10

# Prepare application
bin/console cache:clear
bin/console doctrine:migration:migrate -n --allow-no-migration
