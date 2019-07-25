#!/bin/bash

set -xe

declare -A DIRS

# Build a list of modifed container directories
for i in `git diff --name-only HEAD~1`; do
    D=`dirname $i`
    if test -f $D/Dockerfile; then
	DIRS[$D]=1
    fi
done

# Kick off required docker builds
for i in ${!DIRS[@]}; do
    docker build -t clearlinux/$i:latest $i
done
