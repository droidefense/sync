#!/bin/bash

#
# Copyright Droidefense API. All Rights Reserved.
# SPDX-License-Identifier: GNU GPL v3
#

cd "$(dirname "$0")"

source ./colors.sh
source ./docker_helper.sh
source ./definitions.sh

log "deploying ${syncContainerName}"
# stop previously deployed container if exists.
# useful for ci and tests
if existsContainer ${syncContainerName}; then
	log "stopping previously deployed container"
	docker stop ${syncContainerName} && \
	docker rm ${syncContainerName} && \
	ok "${syncContainerName} container deleted"
fi
	
log "starting ${syncContainerName} container with production docker configuration..."
# -p 4222:4222 \
# -p 8222:8222 \
# -p 6222:6222 \
docker run \
	-d \
	-ti \
	--name ${syncContainerName} \
	--cpus="1" \
	--memory="512m" \
	--log-driver json-file \
	--log-opt mode=non-blocking \
	--log-opt max-buffer-size=4m \
	--log-opt max-file=3 \
	--log-opt max-size=20m \
	--net="bridge" \
	--ulimit nofile=262144:262144 \
	${syncBaseImage}:${syncBaseImageVersion}

ok "${syncContainerName} container deployed"

syncContainerIP=$(getContainerIP ${syncContainerName})
ok "container ${syncContainerName} IP is ${syncContainerIP}"