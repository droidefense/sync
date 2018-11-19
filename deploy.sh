#!/bin/bash

#
# Copyright Droidefense API. All Rights Reserved.
# SPDX-License-Identifier: GNU GPL v3
#

cd "$(dirname "$0")"

containerName="sync.droidefense.com"

source ./helper.sh

if existsContainer $containerName; then
	docker stop $containerName && \
	docker rm $containerName
fi
	
echo "Starting $containerName container with production docker configuration..."
docker run \
	-d \
	-ti \
	--name $containerName \
	--cpus="1" \
	--memory="512m" \
	-p 4222:4222 \
	-p 8222:8222 \
	-p 6222:6222 \
	--log-driver json-file \
	--log-opt mode=non-blocking \
	--log-opt max-buffer-size=4m \
	--log-opt max-file=3 \
	--log-opt max-size=20m \
	--net="host" \
	--ulimit nofile=262144:262144 \
	nats:latest