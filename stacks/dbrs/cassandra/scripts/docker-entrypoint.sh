#!/bin/bash
set -x

#Work in a copy
ORIG_CONFIG_FILE="/workspace/cassandra/conf/cassandra.yaml"
CONFIG_FILE="/workspace/cassandra/conf/cassandra-template.yaml"
ORIG_JVM_OPTIONS_FILE="/workspace/cassandra/conf/jvm-server.options"
JVM_OPTIONS_FILE="/workspace/cassandra/conf/jvm-server.options-template"
SUDOERS_FILE="/etc/sudoers.d/cassandra-user"

function grant_persistent_dirs_permissions {
        sudo /usr/local/bin/change_persistent_dirs_perms.sh
}

function grant_pmem_permissions {
	if [ -d /mnt/pmem ]
	then
		sudo /usr/local/bin/change_fsdax_perms.sh
	elif [ -e /dev/dax0.0 ]
	then
		sudo /usr/local/bin/change_devdax_perms.sh
	else
		echo "No pmem devices are attached to the container on /mnt/pmem(fsdax) or /dev/dax(devdax)!"
                exit 1
        fi
}

function create_jvm_options {
	#function to create jvm-server.options file at runtime
	echo "Generating jvm-server.options file"
        #Determining if the image is going to use devdax or fsdax devices for pmem
        if [ -d /mnt/pmem ]
	then
                CASSANDRA_FSDAX_POOL_SIZE_GB=${CASSANDRA_FSDAX_POOL_SIZE_GB:-'1'}
	        CASSANDRA_PMEM_POOL_NAME=${CASSANDRA_PMEM_POOL_NAME:-'cassandra_pool'}
	        echo -e "-Dpmem_path=/mnt/pmem/$CASSANDRA_PMEM_POOL_NAME\n-Dpool_size=$(echo $(( $CASSANDRA_FSDAX_POOL_SIZE_GB * 1073741824 )) )" | tee -a $JVM_OPTIONS_FILE
        elif [ -e /dev/dax0.0 ]
        then
                echo -e "-Dpmem_path=/dev/dax0.0\n-Dpool_size=0" | tee -a $JVM_OPTIONS_FILE
        else
	        echo "No pmem devices are attached to the container!"
	        exit 1
        fi

        #Copy generated config file to the default location
        echo "Copying generated jvm-server.options template to default config location..."
        cp $JVM_OPTIONS_FILE $ORIG_JVM_OPTIONS_FILE
}

function create_cassandra_yaml {
	#Function to create cassandra.yaml file at runtime
	echo "Generating cassandra.yaml file"
        #Get container IP Address on the first interface
        echo "Getting container primary IP address..."
        CONTAINER_IP=$(ip address | grep inet | egrep -v "inet6|127.0.0.1" | awk '{print $2}' | awk -F "/" '{print $1}' | head -1)
        echo "The container IP address is: $CONTAINER_IP"

        #Cluster name
        CASSANDRA_CLUSTER_NAME=${CASSANDRA_CLUSTER_NAME:-'Cassandra Cluster'}
        echo "cluster_name: '$CASSANDRA_CLUSTER_NAME'" | tee -a $CONFIG_FILE

        #Listen address
        CASSANDRA_LISTEN_ADDRESS=${CASSANDRA_LISTEN_ADDRESS:-$CONTAINER_IP}
        echo "listen_address: '$CASSANDRA_LISTEN_ADDRESS'" | tee -a $CONFIG_FILE

        #Seed addresses
        CASSANDRA_SEED_ADDRESSES=${CASSANDRA_SEED_ADDRESSES:-"$CASSANDRA_LISTEN_ADDRESS:7000"}
        echo -e "seed_provider:\n  - class_name: org.apache.cassandra.locator.SimpleSeedProvider\n    parameters:\n        - seeds: '$CASSANDRA_SEED_ADDRESSES'" | tee -a $CONFIG_FILE

        #Snitch
        CASSANDRA_SNITCH=${CASSANDRA_SNITCH:-'SimpleSnitch'} 
        echo "endpoint_snitch: $CASSANDRA_SNITCH" | tee -a $CONFIG_FILE

        #RPC listen addresss
        CASSANDRA_RPC_ADDRESS=${CASSANDRA_RPC_ADDRESS:-$CONTAINER_IP}
        echo "rpc_address: $CASSANDRA_RPC_ADDRESS" | tee -a $CONFIG_FILE

        #Copy generated config file to the default location
        echo "Copying generated cassandra.yaml template to default config location..."
        cp $CONFIG_FILE $ORIG_CONFIG_FILE
}

grant_persistent_dirs_permissions
grant_pmem_permissions

#Creating jvm-server.options if none provided
if [ ! -f $ORIG_JVM_OPTIONS_FILE ]
then
	create_jvm_options
else
	echo "Using mounted jvm-server.options file..."
fi
#creating cassandra.yaml if none provided
if [ ! -f $ORIG_CONFIG_FILE ]
then
        create_cassandra_yaml
else
	echo "Using mounted cassandra.yaml file..."
fi

echo "Starting Cassandra..."

# first arg is `-f` or `--some-option`
# or there are no args
if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
	set -- /workspace/cassandra/bin/cassandra "$@"
fi

exec "$@"
