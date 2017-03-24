#!/bin/bash -e

export POSTGRESQL_HOST=${POSTGRES_SERVICE_HOST:-coreapi-postgres}
export POSTGRESQL_PORT=${POSTGRES_SERVICE_PORT:-5432}

PGBOUNCER_DIR=/tmp/pgbouncer
USERLIST_TXT=${PGBOUNCER_DIR}/userlist.txt
PGBOUNCER_INI=${PGBOUNCER_DIR}/pgbouncer.ini

mkdir -p ${PGBOUNCER_DIR}

cat > ${USERLIST_TXT} << EOF
"${POSTGRESQL_USER}" "${POSTGRESQL_PASSWORD}"
EOF

cat > ${PGBOUNCER_INI} << EOF
[databases]
${POSTGRESQL_DATABASE} = host=${POSTGRESQL_HOST} port=${POSTGRESQL_PORT}
${POSTGRESQL_INITIAL_DATABASE} = host=${POSTGRESQL_HOST} port=${POSTGRESQL_PORT}

[pgbouncer]
pool_mode = transaction
listen_addr = *
listen_port = 5432
auth_file = ${USERLIST_TXT}
# TODO: we'll want to change this to "cert" or "hba"
auth_type = md5
admin_users = ${POSTGRESQL_USER}
max_client_conn = 10000
default_pool_size = 20
# pgweb refuses to work with extra_float_digits
ignore_startup_parameters = extra_float_digits
EOF

pg_user=$(id -u)
PG_USER_OPT=""

if [ $pg_user == "0" ]; then
    chown pgbouncer:pgbouncer ${USERLIST_TXT}
    chown pgbouncer:pgbouncer ${PGBOUNCER_INI}
    PG_USER_OPT="-u pgbouncer"
fi

pgbouncer ${PG_USER_OPT} ${PGBOUNCER_INI}
