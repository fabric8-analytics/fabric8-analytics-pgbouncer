FROM registry.centos.org/centos/centos:8

MAINTAINER Slavek Kabrda <slavek@redhat.com>

RUN yum install -y https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm &&\
		yum --disablerepo=pgdg94 -y install pgbouncer postgresql &&\
		yum clean all

COPY run-pgbouncer.sh health-check-probe.sh /usr/bin/

EXPOSE 5432

ENTRYPOINT /usr/bin/run-pgbouncer.sh
