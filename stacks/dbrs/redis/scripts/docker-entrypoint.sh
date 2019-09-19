#!/bin/bash
set -x

if [ -d /mnt/pmem0 ]
then
        chown redis-user -R /mnt/pmem0/
        chmod -R a+rw /mnt/pmem0
else
        echo "No pmem devices (fsdax) are attached to the container on /mnt/pmem0"
        exit 1
fi

if [ "${1#-}" != "$1" ] || [ "${1%.conf}" != "$1" ]; then
        set -- redis-server "$@"
fi

exec "$@"
