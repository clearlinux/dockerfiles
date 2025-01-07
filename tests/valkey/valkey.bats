#!/usr/bin/env bats
# Copyright (C) 2018 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

load ../utils

@test "valkey LPUSH test" {
    # start the container first
    docker run --name valkey-server --rm -d ghcr.io/clearlinux/valkey valkey-server --protected-mode no
    sleep 5
    run check_container_status valkey-server
    [ "$status" -eq 0 ]

    # get ip address
    run get_container_ip valkey-server
    [ "$status" -eq 0 ]
    ipaddr="$output"

    # push two integers
    docker run --rm ghcr.io/clearlinux/valkey redis-cli -h $ipaddr lpush mylist x
    docker run --rm ghcr.io/clearlinux/valkey redis-cli -h $ipaddr lpush mylist y

    # stop the container
    docker stop valkey-server
    sleep 3
    run check_container_status valkey-server
    [ "$status" -eq 1 ]
}

@test "valkey LRANGE test" {
    # start tje container first
    docker run --name valkey-server --rm -d ghcr.io/clearlinux/valkey valkey-server --protected-mode no
    sleep 5
    run check_container_status valkey-server
    [ "$status" -eq 0 ]

    # get ip address
    run get_container_ip valkey-server
    [ "$status" -eq 0 ]
    ipaddr="$output"

    # push two integers
    docker run --rm ghcr.io/clearlinux/valkey redis-cli -h $ipaddr lrange mylist 0 -1

    # stop the container
    docker stop valkey-server
    sleep 3
    run check_container_status valkey-server
    [ "$status" -eq 1 ]
}

