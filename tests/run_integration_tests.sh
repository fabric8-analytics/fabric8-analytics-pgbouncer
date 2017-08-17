#!/bin/bash -ex

# Check that we can connect to Postgres through PgBouncer container.

pgbouncer_image=${PGBOUNCER_IMAGE:-registry.devshift.net/bayesian/coreapi-pgbouncer:latest}
postgres_image='registry.centos.org/sclo/postgresql-94-centos7:latest'
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
postgres_env="${here}/postgres.env"
pgbouncer_env="${here}/pgbouncer.env"
check_script="${here}/check_connection.sh"

gc() {
    retval=$?
    echo "${postgres_container_name} ${pgbouncer_container_name}" | xargs -r docker rm -vf || :
    [[ $retval -ne 0 ]] && echo "Test Failed."
    exit $retval
}
trap gc EXIT SIGINT

postgres_container_name=$(docker run -d --env-file ${postgres_env} ${postgres_image})
echo "Postgres container name is ${postgres_container_name}."

echo "Waiting for Postgres..."
sleep 10

pgbouncer_container_name=$(docker run -d -v ${check_script}:/check.sh:ro,Z --link=${postgres_container_name} --env-file ${pgbouncer_env} -e POSTGRES_SERVICE_HOST=${postgres_container_name} ${pgbouncer_image})
echo "PgBouncer container name is ${pgbouncer_container_name}."

docker exec -t ${pgbouncer_container_name} /check.sh

echo "Test Passed."

