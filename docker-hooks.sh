#!/bin/bash

CLR_URL="https://cdn.download.clearlinux.org/releases"

# Return tag value or NULL if not found
function get_tag {
    pkg=$1

    clr_ver=`docker run --rm clearlinux/os-core cat /usr/lib/os-release | grep VERSION_ID`
    clr_ver=${clr_ver##*=}
    src_url="$CLR_URL/$clr_ver/clear/source/package-sources"
    matches=$(curl $src_url 2>/dev/null | grep $pkg)

    # no matches, return NULL tag
    if [ -z "$matches" ]; then
        echo "no $pkg found on the release $clr_ver"
        exit 1
    fi

    matches=($matches)
    for((j=0;j<${#matches[@]};j++))
    do
        if [ ${matches[j]} == $pkg ]; then
            ver=${matches[j+1]}
        fi
    done

    echo "$ver"
}

function get_tags_in_docker {
    img=$1

    tag_url="https://registry.hub.docker.com/v2/repositories/$img/tags/"
    tags=$(curl $tag_url 2>/dev/null | docker run -i stedolan/jq  '."results"[]["name"]')
    echo $tags
}

function tag_and_push {
    local tag=$1
    local major_tag=$2

    set -e
    docker tag $image:latest $image:$tag
    docker push $image:$tag
    docker tag $image:latest $image:$major_tag
    docker push $image:$major_tag
}
