#!/usr/bin/env bats
# Copyright (C) 2018 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

load ../utils
load ../security

@test "1191 test" {
    # start container first
    docker run --name memcached-server --detach clearlinux/memcached
    run check_container_status memcached-server
    [ "$status" -eq 0 ]
    run Test_1191 clearlinux/memcached
    [ "$output" == "pass" ]

    # stop the container
    docker rm -f memcached-server
    sleep 3
    run check_container_status memcached-server
    [ "$status" -eq 1 ]
}

@test "1195 test" {
    # start container first
    docker run --name memcached-server --detach clearlinux/memcached
    run check_container_status memcached-server
    [ "$status" -eq 0 ]
    run Test_1195 clearlinux/memcached
    [ "$output" == "pass" ]

    # stop the container
    docker rm -f memcached-server
    sleep 3
    run check_container_status memcached-server
    [ "$status" -eq 1 ]
}

@test "1215 test" {
    # start container first
    docker run --name memcached-server --detach --security-opt=no-new-privileges clearlinux/memcached
    run check_container_status memcached-server
    [ "$status" -eq 0 ]
    run Test_1215 clearlinux/memcached
    [ "$output" == "pass" ]

    # stop the container
    docker rm -f memcached-server
    sleep 3
    run check_container_status memcached-server
    [ "$status" -eq 1 ]
}


