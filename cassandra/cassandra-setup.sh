swupd bundle-add cassandra
swupd bundle-add which
BIN_CASSANDRA="/usr/share/cassandra/bin"
BIN_CASSANDRA_TOOL="/usr/share/cassandra/tools/bin"
export PATH=$PATH:$BIN_CASSANDRA:$BIN_CASSANDRA_TOOL
chmod -R 777 /usr/share/cassandra/tools/bin

