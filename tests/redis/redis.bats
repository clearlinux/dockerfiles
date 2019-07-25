#!/usr/bin/env bats
# Copyright (C) 2018 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

load ../utils

@test "Redis LPUSH test" {
    # start tje container first
    docker run --name redis-server --rm -d clearlinux/redis redis-server --protected-mode no
    sleep 5
    run check_container_status redis-server
    [ "$status" -eq 0 ]

    # get ip address
    run get_container_ip redis-server
    [ "$status" -eq 0 ]
    ipaddr="$output"

    # push two integers
    docker run --rm clearlinux/redis redis-cli -h $ipaddr lpush mylist x
    docker run --rm clearlinux/redis redis-cli -h $ipaddr lpush mylist y

    # stop the container
    docker stop redis-server
    sleep 3
    run check_container_status redis-server
    [ "$status" -eq 1 ]
}

@test "Redis LRANGE test" {
    # start tje container first
    docker run --name redis-server --rm -d clearlinux/redis redis-server --protected-mode no
    sleep 5
    run check_container_status redis-server
    [ "$status" -eq 0 ]

    # get ip address
    run get_container_ip redis-server
    [ "$status" -eq 0 ]
    ipaddr="$output"

    # push two integers
    docker run --rm clearlinux/redis redis-cli -h $ipaddr lrange mylist 0 -1

    # stop the container
    docker stop redis-server
    sleep 3
    run check_container_status redis-server
    [ "$status" -eq 1 ]
}

