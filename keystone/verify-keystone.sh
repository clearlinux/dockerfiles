#!/bin/bash

# Verification Keystone Service commands
source /root/openrc

for i in {1..5}; do openstack user list && break || sleep 1; done
openstack endpoint list
openstack project list

