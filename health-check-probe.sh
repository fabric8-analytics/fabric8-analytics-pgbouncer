#!/usr/bin/env bash
# This script is used as a liveness probe.

echo
echo "SHOW STATS; (`date`)"
PGPASSWORD=$POSTGRESQL_PASSWORD psql -h localhost -U $POSTGRESQL_USER -d pgbouncer -c "SHOW STATS;"
echo "SHOW CLIENTS; (`date`)"
PGPASSWORD=$POSTGRESQL_PASSWORD psql -h localhost -U $POSTGRESQL_USER -d pgbouncer -c "SHOW CLIENTS;"
echo "SHOW SERVERS; (`date`)"
PGPASSWORD=$POSTGRESQL_PASSWORD psql -h localhost -U $POSTGRESQL_USER -d pgbouncer -c "SHOW SERVERS;"
echo "SHOW POOLS; (`date`)"
PGPASSWORD=$POSTGRESQL_PASSWORD psql -h localhost -U $POSTGRESQL_USER -d pgbouncer -c "SHOW POOLS;"

PGPASSWORD=$POSTGRESQL_PASSWORD psql -h localhost -U $POSTGRESQL_USER -d $POSTGRESQL_INITIAL_DATABASE -tc "SELECT 1;" | grep -q 1
