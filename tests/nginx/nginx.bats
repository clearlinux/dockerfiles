#!/usr/bin/env bats
# Copyright (C) 2018 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

load ../utils


@test "Start nginx server" {
    sudo docker run --name nginx-server --rm -d -p 8080:80 clearlinux/nginx
    sleep 5
    run check_container_status nginx-server
    [ "$status" -eq 0 ]
}

@test "Connecting to nginx server" {
    curl -svL http://localhost:8080/
}

@test "Stop nginx server" {
    sudo docker stop nginx-server
    sleep 3
    run check_container_status nginx-server
    [ "$status" -eq 1 ]
}
