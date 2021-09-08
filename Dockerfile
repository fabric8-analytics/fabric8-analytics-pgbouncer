FROM registry.access.redhat.com/ubi8:latest

MAINTAINER Slavek Kabrda <slavek@redhat.com>

# install dependencies required by pgbouncer
RUN yum install -y http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/c-ares-1.13.0-5.el8.x86_64.rpm 

RUN	yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-ppc64le/pgdg-redhat-repo-latest.noarch.rpm  &&\
		yum --disablerepo=pgdg94 -y install pgbouncer postgresql &&\
		yum clean all

COPY run-pgbouncer.sh health-check-probe.sh /usr/bin/

EXPOSE 5432

ENTRYPOINT /usr/bin/run-pgbouncer.sh
