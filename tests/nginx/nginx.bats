#!/usr/bin/env bats
# Copyright (C) 2018 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

load ../utils


@test "Connecting to nginx server" {
    # start the container first
    docker run --name nginx-server --rm -d -p 8080:80 clearlinux/nginx
    sleep 5
    run check_container_status nginx-server
    [ "$status" -eq 0 ]

    curl -svL http://localhost:8080/

    # stop the container
    docker stop nginx-server
    sleep 3
    run check_container_status nginx-server
    [ "$status" -eq 1 ]
}
