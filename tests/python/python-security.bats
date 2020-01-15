#!/usr/bin/env bats
# Copyright (C) 2018 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

load ../utils
load ../security

@test "1191 test" {
    # start container first
    docker run --name python-server --detach clearlinux/python sleep 60
    run check_container_status python-server
    [ "$status" -eq 0 ]
    run Test_1191 clearlinux/python
    [ "$output" == "pass" ]

    # stop the container
    docker rm -f python-server
    sleep 3
    run check_container_status python-server
    [ "$status" -eq 1 ]
}

@test "1195 test" {
    # start container first
    docker run --name python-server --detach clearlinux/python sleep 60
    run check_container_status python-server
    [ "$status" -eq 0 ]
    run Test_1195 clearlinux/python
    [ "$output" == "pass" ]

    # stop the container
    docker rm -f python-server
    sleep 3
    run check_container_status python-server
    [ "$status" -eq 1 ]
}

@test "1215 test" {
    # start container first
    docker run --name python-server --detach --security-opt=no-new-privileges clearlinux/python sleep 60
    run check_container_status python-server
    [ "$status" -eq 0 ]
    run Test_1215 clearlinux/python
    [ "$output" == "pass" ]

    # stop the container
    docker rm -f python-server
    sleep 3
    run check_container_status python-server
    [ "$status" -eq 1 ]
}


