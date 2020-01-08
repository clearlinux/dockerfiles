#!/usr/bin/env bash
TEST_UNITS=$1
cd $TEST_UNITS
bats -t $TEST_UNITS.bats
if [ -f $TEST_UNITS-security.bats ];then
	bats -t $TEST_UNITS-security.bats
fi
