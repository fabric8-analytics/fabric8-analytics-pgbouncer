#!/bin/bash -ex

# This script should run inside PgBouncer container.

PGPASSWORD=${POSTGRESQL_PASSWORD} psql -h localhost -U ${POSTGRESQL_USER} -d ${POSTGRESQL_DATABASE} -tc "SELECT 1;" | grep -q 1

