#!/bin/bash
#

# Copyright (c) 2015-2018 Bitnami

# PostgreSQL setup

# shellcheck disable=SC1090
# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail

# Load Generic Libraries
. /libfile.sh
. /liblog.sh
. /libservice.sh
. /libvalidations.sh
. /libfs.sh
. /libos.sh
. /libpostgresql.sh

# Load PostgreSQL environment variables
eval "$(postgresql_env)"

# Ensure PostgreSQL environment variables settings are valid
postgresql_validate
# Ensure PostgreSQL is stopped when this script ends.
trap "postgresql_stop" EXIT
# Ensure 'daemon' user exists when running as 'root'
am_i_root && ensure_user_exists "$POSTGRESQL_DAEMON_USER" "$POSTGRESQL_DAEMON_GROUP"
# Allow running custom pre-initialization scripts
postgresql_custom_pre_init_scripts
# Ensure PostgreSQL is initialized
postgresql_initialize
# Allow running custom initialization scripts
postgresql_custom_init_scripts

# Allow remote connections once the initialization is finished
if ! postgresql_is_file_external "postgresql.conf"; then
    info "Enabling remote connections"
    postgresql_enable_remote_connections
    postgresql_set_property "port" "$POSTGRESQL_PORT_NUMBER"
fi
