#!/bin/bash
#Script for building cassandra with pmem support on Clear Linux
#Bundle dependencies: c-basic java-basic devpkg-pmdk pmdk
#
#All the repositories are built on CASSANDRA_BUILD_DIR and a tar.gz file is generated
#on the folder you run this script
export JAVA_HOME='/usr/lib/jvm/java-1.8.0-openjdk'

INITIAL_DIR=$(pwd)
CASSANDRA_BUILD_DIR='/tmp/cassandra-build'
LLPL_REPO='https://github.com/pmem/llpl.git'
CASSANDRA_PMEM_REPO='https://github.com/intel/cassandra-pmem'
CASSANDRA_PMEM_BRANCH='13981_llpl_engine'

if [ -d $CASSANDRA_BUILD_DIR ] 
then
	rm -rf $CASSANDRA_BUILD_DIR/*
else
	mkdir $CASSANDRA_BUILD_DIR
fi

#Build LLPL
cd $CASSANDRA_BUILD_DIR
git clone $LLPL_REPO && \
cd $CASSANDRA_BUILD_DIR/llpl && \
make && \
cd $CASSANDRA_BUILD_DIR/llpl/target/classes && \
jar cvf llpl.jar lib/


#Build Cassandra PMEM
cd $CASSANDRA_BUILD_DIR && \
git clone -b $CASSANDRA_PMEM_BRANCH --single-branch  $CASSANDRA_PMEM_REPO && \
cd $CASSANDRA_BUILD_DIR/cassandra-pmem && \
cp $CASSANDRA_BUILD_DIR/llpl/target/classes/llpl.jar $CASSANDRA_BUILD_DIR/cassandra-pmem/lib/ && \
cp $CASSANDRA_BUILD_DIR/llpl/target/cppbuild/libllpl.so $CASSANDRA_BUILD_DIR/cassandra-pmem/lib/sigar-bin/ && \
ant -autoproxy && \
cd $CASSANDRA_BUILD_DIR && \
mv cassandra-pmem cassandra
tar -zcvf cassandra-pmem-build.tar.gz cassandra
mv cassandra-pmem-build.tar.gz $INITIAL_DIR
cd $INITIAL_DIR
