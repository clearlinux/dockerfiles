#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purpose
# shellcheck disable=SC1091

# Load libraries
. /libpostgresql.sh
. /libos.sh

# Load PostgreSQL environment variables
eval "$(postgresql_env)"
readonly flags=("-D" "$POSTGRESQL_DATA_DIR" "--config-file=$POSTGRESQL_CONF_FILE" "--external_pid_file=$POSTGRESQL_PID_FILE" "--hba_file=$POSTGRESQL_PGHBA_FILE")
readonly cmd=$(command -v postgres)

info "** Starting PostgreSQL **"
if am_i_root; then
    exec su-exec "$POSTGRESQL_DAEMON_USER" "${cmd}" "${flags[@]}"
else
    exec "${cmd}" "${flags[@]}"
fi
