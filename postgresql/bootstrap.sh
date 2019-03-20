#!/bin/bash
set -xe
source /usr/share/defaults/etc/bash.bashrc

PWFILE="$(mktemp)"
if [[ -n "$PGSQL_ROOT_PASSWORD" ]]; then
	echo "$PGSQL_ROOT_PASSWORD" > "$PWFILE"
	chown postgres:postgres "$PWFILE"
	PWOPTION="--username root --pwfile $PWFILE"
fi
su postgres -s /bin/bash -c "pg_ctl init -D /var/lib/pgsql/data -o \"$PWOPTION --auth=trust\""
rm -f "$PWFILE"
su postgres -s /bin/bash -c 'pg_ctl start -D /var/lib/pgsql/data'
