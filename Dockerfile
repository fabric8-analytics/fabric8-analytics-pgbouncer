FROM registry.centos.org/centos/centos:7

MAINTAINER Slavek Kabrda <slavek@redhat.com>

RUN yum install -y https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm &&\
		yum -y install pgbouncer postgresql &&\
		yum clean all

COPY run-pgbouncer.sh health-check-probe.sh /usr/bin/

EXPOSE 5432

ENTRYPOINT /usr/bin/run-pgbouncer.sh
