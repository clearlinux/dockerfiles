#!/usr/bin/env bats
# Copyright (C) 2018 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

load ../utils
load ../security

@test "SDL T1191 test" {
    # start container first
    docker run --name ruby-server --detach clearlinux/ruby
    run check_container_status ruby-server
    [ "$status" -eq 0 ]
    run Test_SDL_T1191 clearlinux/ruby
    [ "$output" == "pass" ]

    # stop the container
    docker rm -f ruby-server
    sleep 3
    run check_container_status ruby-server
    [ "$status" -eq 1 ]
}

@test "SDL T1195 test" {
    # start container first
    docker run --name ruby-server --detach clearlinux/ruby
    run check_container_status ruby-server
    [ "$status" -eq 0 ]
    run Test_SDL_T1195 clearlinux/ruby
    [ "$output" == "pass" ]

    # stop the container
    docker rm -f ruby-server
    sleep 3
    run check_container_status ruby-server
    [ "$status" -eq 1 ]
}

@test "SDL T1215 test" {
    # start container first
    docker run --name ruby-server --detach --security-opt=no-new-privileges clearlinux/ruby
    run check_container_status ruby-server
    [ "$status" -eq 0 ]
    run Test_SDL_T1215 clearlinux/ruby
    [ "$output" == "pass" ]

    # stop the container
    docker rm -f ruby-server
    sleep 3
    run check_container_status ruby-server
    [ "$status" -eq 1 ]
}


