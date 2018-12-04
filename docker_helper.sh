#/bin/bash

#
# Copyright Droidefense API. All Rights Reserved.
# SPDX-License-Identifier: GNU GPL v3
#

# Check whether a given container (filtered by name) exists or not
function existsContainer(){
	containerName=$1
	result=$(docker ps -aq -f name=$containerName)
	if [ -n $result ]; then
	    return 0 #true
	else
		return 1 #false
	fi
}

# check if a container is missing given its name
function isContainerMissing(){
	containerName=$1
	result=$(docker ps -aq -f name=$containerName)
	if [ -n $result ]; then
	    return 1 #false
	else
		return 0 #true
	fi
}

# given a container name, get its docker assigned IP
function getContainerIP(){
	containerName=$1
	containerIP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $containerName)
	echo $containerIP
}