#!/bin/bash -ex

yum -y update
yum -y install docker

systemctl start docker

./tests/run_integration_tests.sh

