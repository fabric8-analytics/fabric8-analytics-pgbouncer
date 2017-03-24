#!/usr/bin/env bash
# This script is used as a liveness probe.

PGPASSWORD=$POSTGRESQL_PASSWORD psql -h localhost -U $POSTGRESQL_USER -d $POSTGRESQL_INITIAL_DATABASE -tc "SELECT 1;" | grep -q 1
