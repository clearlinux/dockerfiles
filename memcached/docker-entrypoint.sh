#!/bin/bash
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- memcached "$@"
fi

if [ "$1" = 'memcached' -a "$(id -u)" = '0' ]; then
        echo "memcached -s /bin/bash -c \"$0 $@\"" | xargs su
fi

exec "$@"
