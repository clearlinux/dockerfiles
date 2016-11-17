#!/bin/bash
# This scripts informs CI about a working Keystone Service

source /root/openrc

for i in {1..5}; do echo "Test #$i"; openstack user list && break || sleep 5; done

openstack endpoint list

openstack project list

