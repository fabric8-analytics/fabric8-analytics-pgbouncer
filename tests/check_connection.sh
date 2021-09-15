#!/bin/bash -ex

# This script should run inside PgBouncer container.
PGPASSWORD=${POSTGRESQL_PASSWORD} psql -h ${POSTGRESQL_HOST} -U ${POSTGRESQL_USERNAME} -d ${POSTGRESQL_DATABASE} -tc "SELECT 1;" | grep -q 1

