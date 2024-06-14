#!/bin/bash

set -eu -o pipefail

create_image() {
    local name="$1"
    local ver="$2"
    pushd "${name}"
    docker build -t ghcr.io/clearlinux/"${name}":"${ver}" . --build-arg="clear_ver=${ver}"
    popd
}

push_image() {
    local name="$1"
    local ver="$2"
    docker push ghcr.io/clearlinux/"${name}":"${ver}"
}

build_and_push_image() {
    local name="$1"
    local ver="$2"
    create_image "${name}" "${ver}"
    push_image "${name}" "${ver}"
}

main() {
    local ver="$1"
    build_and_push_image os-core "${ver}"
    # httpd is used by cgit so it must be pushed first
    build_and_push_image httpd "${ver}"
    build_and_push_image cgit "${ver}"
    build_and_push_image golang "${ver}"
    build_and_push_image haproxy "${ver}"
    build_and_push_image iperf "${ver}"
    build_and_push_image mariadb "${ver}"
    build_and_push_image memcached "${ver}"
    build_and_push_image nginx "${ver}"
    build_and_push_image node "${ver}"
    build_and_push_image numpy-mp "${ver}"
    build_and_push_image perl "${ver}"
    build_and_push_image php "${ver}"
    build_and_push_image php-fpm "${ver}"
    build_and_push_image postgres "${ver}"
    build_and_push_image python "${ver}"
    build_and_push_image rabbitmq "${ver}"
    build_and_push_image r-base "${ver}"
    build_and_push_image redis "${ver}"
    build_and_push_image ruby "${ver}"
    build_and_push_image tesseract-ocr "${ver}"
}

main $1
