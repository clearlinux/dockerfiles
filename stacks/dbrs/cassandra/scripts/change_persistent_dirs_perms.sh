#!/bin/bash
DATA_DIR="/workspace/cassandra/data"
LOG_DIR="/workspace/cassandra/logs"

/usr/bin/chown cassandra-user -R $DATA_DIR
/usr/bin/chown cassandra-user -R $LOG_DIR
