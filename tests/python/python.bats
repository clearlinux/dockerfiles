#!/usr/bin/env bats
# *-*- Mode: sh; c-basic-offset: 8; indent-tabs-mode: nil -*-*

load ../utils

@test "python3 string" {
    sudo docker run --rm -v "$PWD":/src -w /src clearlinux/python python3 testcase/string3.py 
}

@test "python3 list" {
    sudo docker run --rm -v "$PWD":/src -w /src clearlinux/python python3 testcase/list3.py
}

@test "python3 count" {
    sudo docker run --rm -v "$PWD":/src -w /src clearlinux/python python3 testcase/wordcount3.py --count testcase/string3.py
}

@test "python3-basic pip3 check" {
    sudo docker run --rm -v "$PWD":/src -w /src clearlinux/python pip3 check
}

