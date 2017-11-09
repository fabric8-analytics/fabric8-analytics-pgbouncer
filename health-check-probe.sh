#!/usr/bin/env bash
# This script is used as a liveness probe.
echo "localhost:5432:$POSTGRESQL_INITIAL_DATABASE:$POSTGRESQL_USER:$POSTGRESQL_PASSWORD" > ~/.pgpass
chmod 0600 ~/.pgpass
psql -h localhost -U $POSTGRESQL_USER -d $POSTGRESQL_INITIAL_DATABASE -tc "SELECT 1;" | grep -q 1

