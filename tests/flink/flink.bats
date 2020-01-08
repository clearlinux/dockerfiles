#!/usr/bin/env bats
# *-*- Mode: sh; c-basic-offset: 8; indent-tabs-mode: nil -*-*

load ../utils

@test "Start flink cluster" {
    docker run --name flink-cluster --rm -d -p 8081:8081 clearlinux/flink jobmanager
    sleep 5
    run check_container_status flink-cluster
    [ "$status" -eq 0 ]
}

@test "Connecting to flink cluster" {
    curl --silent -X GET --noproxy 'localhost' 'http://localhost:8081/' \
       | grep "Apache Flink Web Dashboard"
}

@test "Stop flink cluster" {
    docker stop flink-cluster
    sleep 3
    run check_container_status flink-cluster
    [ "$status" -eq 1 ]
}

