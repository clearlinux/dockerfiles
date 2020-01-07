#!/usr/bin/env bats
# Copyright (C) 2018 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

load ../utils
load ../security

@test "SDL T1191 test" {
    # start container first
    docker run --name redis-server --detach clearlinux/redis
    run check_container_status redis-server
    [ "$status" -eq 0 ]
    run Test_SDL_T1191 clearlinux/redis
    [ "$output" == "pass" ]

    # stop the container
    docker rm -f redis-server
    sleep 3
    run check_container_status redis-server
    [ "$status" -eq 1 ]
}

@test "SDL T1195 test" {
    # start container first
    docker run --name redis-server --detach clearlinux/redis
    run check_container_status redis-server
    [ "$status" -eq 0 ]
    run Test_SDL_T1195 clearlinux/redis
    [ "$output" == "pass" ]

    # stop the container
    docker rm -f redis-server
    sleep 3
    run check_container_status redis-server
    [ "$status" -eq 1 ]
}

@test "SDL T1215 test" {
    # start container first
    docker run --name redis-server --detach --security-opt=no-new-privileges clearlinux/redis
    run check_container_status redis-server
    [ "$status" -eq 0 ]
    run Test_SDL_T1215 clearlinux/redis
    [ "$output" == "pass" ]

    # stop the container
    docker rm -f redis-server
    sleep 3
    run check_container_status redis-server
    [ "$status" -eq 1 ]
}


