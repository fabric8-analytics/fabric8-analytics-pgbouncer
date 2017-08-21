REGISTRY?=registry.devshift.net
REPOSITORY?=bayesian/coreapi-pgbouncer
TAG?=$(shell git rev-parse --short HEAD)

.PHONY: all docker-build fast-docker-build test get-image-name get-image-tag

all: fast-docker-build

docker-build:
	docker build --no-cache -t $(REGISTRY)/$(REPOSITORY):$(TAG) .

fast-docker-build:
	docker build -t $(REGISTRY)/$(REPOSITORY):$(TAG) .

test: fast-docker-build
	./tests/run_integration_tests.sh

get-image-name:
	@echo $(REGISTRY)/$(REPOSITORY):$(TAG)

get-image-tag:
	@echo $(TAG)

