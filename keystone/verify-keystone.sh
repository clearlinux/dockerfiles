#!/bin/bash
# This scripts informs CI about a working Keystone Service

source /root/openrc

for i in {1..5}; do openstack user list && break || sleep 1; done
openstack endpoint list
openstack project list

