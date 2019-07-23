#!/usr/bin/env bats
# Copyright (C) 2018 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

load ../utils

@test "Start redis server" {
    sudo docker run --name redis-server --rm -d clearlinux/redis redis-server --protected-mode no
    sleep 5 
    run check_container_status redis-server
    [ "$status" -eq 0 ]
}

@test "Redis LPUSH test" {
    # get ip address
    run get_container_ip redis-server
    [ "$status" -eq 0 ]
    ipaddr="$output"

    # push two integers
    sudo docker run --rm clearlinux/redis redis-cli -h $ipaddr lpush mylist x
    sudo docker run --rm clearlinux/redis redis-cli -h $ipaddr lpush mylist y
}

@test "Redis LRANGE test" {
    # get ip address
    run get_container_ip redis-server
    [ "$status" -eq 0 ]
    ipaddr="$output"

    # push two integers
    sudo docker run --rm clearlinux/redis redis-cli -h $ipaddr lrange mylist 0 -1
}


@test "Stop redis server" {
    sudo docker stop redis-server
    sleep 3
    run check_container_status redis-server
    [ "$status" -eq 1 ]
}
