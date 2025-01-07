#!/usr/bin/env bats
# Copyright (C) 2018 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

load ../utils
load ../security

@test "1191 test" {
    # start container first
    docker run --name valkey-server --detach ghcr.io/clearlinux/valkey
    run check_container_status valkey-server
    [ "$status" -eq 0 ]
    run Test_1191 ghcr.io/clearlinux/valkey
    [ "$output" == "pass" ]

    # stop the container
    docker rm -f valkey-server
    sleep 3
    run check_container_status valkey-server
    [ "$status" -eq 1 ]
}

@test "1195 test" {
    # start container first
    docker run --name valkey-server --detach ghcr.io/clearlinux/valkey
    run check_container_status valkey-server
    [ "$status" -eq 0 ]
    run Test_1195 ghcr.io/clearlinux/valkey
    [ "$output" == "pass" ]

    # stop the container
    docker rm -f valkey-server
    sleep 3
    run check_container_status valkey-server
    [ "$status" -eq 1 ]
}

@test "1215 test" {
    # start container first
    docker run --name valkey-server --detach --security-opt=no-new-privileges ghcr.io/clearlinux/valkey
    run check_container_status valkey-server
    [ "$status" -eq 0 ]
    run Test_1215 ghcr.io/clearlinux/valkey
    [ "$output" == "pass" ]

    # stop the container
    docker rm -f valkey-server
    sleep 3
    run check_container_status valkey-server
    [ "$status" -eq 1 ]
}


