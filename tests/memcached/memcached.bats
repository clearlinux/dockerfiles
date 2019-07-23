#!/usr/bin/env bats
# Copyright (C) 2018 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

load ../utils


@test "Start memcached server" {
    sudo docker run --name memcached-server --rm -d clearlinux/memcached
    sleep 5
    run check_container_status memcached-server
    [ "$status" -eq 0 ]
}

@test "Accessing statistics" {
    # get ip address
    run get_container_ip memcached-server
    [ "$status" -eq 0 ]
    ipaddr="$output"

    echo stats | nc $ipaddr 11211
}


@test "Stop memcached server" {
    sudo docker stop memcached-server
    sleep 3
    run check_container_status memcached-server
    [ "$status" -eq 1 ]
}
