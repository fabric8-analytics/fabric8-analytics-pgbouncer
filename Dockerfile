FROM registry.centos.org/centos/centos:8

MAINTAINER Slavek Kabrda <slavek@redhat.com>

RUN	yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-ppc64le/pgdg-redhat-repo-latest.noarch.rpm &&\
        yum --disablerepo=pgdg94 -y install pgbouncer postgresql &&\
		yum clean all

COPY run-pgbouncer.sh health-check-probe.sh /usr/bin/

EXPOSE 5432

ENTRYPOINT /usr/bin/run-pgbouncer.sh
