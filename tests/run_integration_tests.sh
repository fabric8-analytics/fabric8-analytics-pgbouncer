#!/bin/bash -ex

# Check that we can connect to Postgres through PgBouncer container.

pgbouncer_image=${IMAGE_NAME:-docker.io/bitnami/pgbouncer:latest}
postgres_image='registry.centos.org/centos/postgresql-94-centos7:latest'
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

postgres_container_name=$(docker run --name postgresql -d --env-file ${postgres_env} ${postgres_image})
echo "Postgres container name is ${postgres_container_name}."

echo "Waiting for Postgres..."
sleep 10

postgresql_host=$(docker inspect --format {{.NetworkSettings.IPAddress}} postgresql)

pgbouncer_container_name=$(docker run -d -v ${check_script}:/check.sh:ro,Z --env-file ${pgbouncer_env} --link=${postgres_container_name} \
    -e "POSTGRESQL_HOST=${postgresql_host}"  ${pgbouncer_image})


echo "PgBouncer container name is ${pgbouncer_container_name}."

docker exec -i ${pgbouncer_container_name} /check.sh

echo "Test Passed."

