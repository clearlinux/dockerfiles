#!/bin/sh
set -e

if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then
	  set -- node "$@"
fi

echo "IMAGE NAME: $NAME"
echo "IMAGE VERSION: $VERSION"
echo "IMAGE PATH: $PATH"

exec "$@"
