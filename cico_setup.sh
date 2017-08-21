#!/bin/bash -ex

prep() {
    yum -y update
    yum -y install docker
    systemctl start docker
}

build_image() {
    make docker-build
}

prep
