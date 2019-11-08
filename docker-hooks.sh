#!/bin/bash

CLR_URL="https://cdn.download.clearlinux.org/releases"

# Return tag value or NULL if not found
function get_tag {
    pkg=$1

    clr_ver=`docker run --rm clearlinux/os-core cat /usr/lib/os-release | grep VERSION_ID`
    clr_ver=${clr_ver##*=}
    src_url="$CLR_URL/$clr_ver/clear/source/package-sources"

    # use wget in busybox container image
    matches=`docker run --rm  busybox wget -q -O - $src_url | grep $pkg`

    # no matches, return NULL tag
    if [ -z "$matches" ]; then
        echo ""
        echo "no $pkg found on the release $clr_ver"
        exit 0
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

    tag_url="https://registry.hub.docker.com/v2/repositories/$1/tags/"
    tags=$(docker run --rm busybox wget -q -O - $tag_url | docker run -i stedolan/jq  '."results"[]["name"]')
    echo $tags
}

