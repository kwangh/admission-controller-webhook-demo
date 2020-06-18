# Copyright (c) 2019 StackRox Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# https://danishpraka.sh/2019/12/07/using-makefiles-for-go.html
# Makefile for building the Admission Controller webhook demo server + docker image.

.DEFAULT_GOAL := docker-build

IMAGE ?= kh/admission-controller-webhook-demo:latest

.PHONY: setup
## setup: setup go modules
setup:
	go mod init admission-controller \
		&& go mod tidy \
		&& go mod vendor

## make: build webhook server and docker image
image/webhook-server: $(shell find . -name '*.go')
	CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o $@ ./webhook-server

.PHONY: docker-build
docker-build: image/webhook-server
	docker build -t $(IMAGE) image/

.PHONY: docker-push
docker-push: docker-build
	docker push $(IMAGE)

.PHONY: clean
## clean: cleans the binary
clean:
	rm image/webhook-server

.PHONY: help
## help: Prints this help message
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
