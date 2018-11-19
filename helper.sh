#!/bin/bash

#
# Copyright Droidefense API. All Rights Reserved.
# SPDX-License-Identifier: GNU GPL v3
#

# HELPER FUNCTIONS
# Check whether a given container (filtered by name) exists or not
function existsContainer(){
	containerName=$1
	if [ -n "$(docker ps -aq -f name=$containerName)" ]; then
	    return 0 #true
	else
		return 1 #false
	fi
}