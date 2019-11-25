#!/bin/bash

CLR_URL="https://cdn.download.clearlinux.org/releases"

# Return tag value or NULL if not found
function get_tag {
    local pkg=$1

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
    local img=$1

    tag_url="https://registry.hub.docker.com/v2/repositories/$img/tags/"
    tags=$(curl $tag_url 2>/dev/null | docker run -i stedolan/jq  '."results"[]["name"]')
    echo $tags
}

# Do tagging and tagged image push
# param 1, exact tag, x.y.z
# param 2, container image name
# param 3 (optional), base tag name, default is "latest"
function tag_and_push {
    # For version format x.y.z, three tags as below
    #   tag: x.y.z
    #   tag1: x.y
    #   tag2: x
    local tag=$1
    local tag1=${tag%.*}
    local tag2=${tag%%.*}
    local image=$2
    local base=$3

    if [ -z "$base" ]; then
        base=latest
    fi

    set -e
    docker tag $image:$base $image:$tag
    docker push $image:$tag
    docker tag $image:$base $image:$tag1
    docker push $image:$tag1
    docker tag $image:$base $image:$tag2
    docker push $image:$tag2
}

function do_tag {
    local image=$1
    local pkg=$2
    local base=$3
    
    echo "=> Tagging the $image"
    local tag=$(get_tag $pkg)

    if [ $? -eq 0 ] && [ -n "$tag" ]; then
        tag_and_push $tag $image $base
    fi
}
