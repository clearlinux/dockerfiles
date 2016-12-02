#!/bin/bash

IDENTITY_HOST="${IDENTITY_HOST:-localhost}"
CONTROLLER_HOST="${CONTROLLER_HOST:-localhost}"
CEPH_ID="${CEPH_ID:-admin}"

sed -i.bak s/CONTROLLER_HOST/$CONTROLLER_HOST/g /root/ciaorc
sed -i.bak s/IDENTITY_HOST/$IDENTITY_HOST/g /root/ciaorc

# compile the code before running it
go install github.com/01org/ciao/...
cp -f $GOBIN/* /usr/bin

mkdir -p /var/lib/ciao/data/controller/
cp -r /root/go/src/github.com/01org/ciao/ciao-controller/tables /var/lib/ciao/data/controller/
cp -r /root/go/src/github.com/01org/ciao/ciao-controller/workloads /var/lib/ciao/data/controller/

if [ ! -d "/etc/ssl" ] ; then
    hash=`c_hash /etc/ca-certs/cacert.pem | cut -d ' ' -f1`
    ln -s /etc/ca-certs/cacert.pem /etc/ca-certs/$hash
    mkdir -p /etc/ssl
    ln -s /etc/ca-certs/ /etc/ssl/certs
    ln -s /etc/ca-certs/cacert.pem /usr/share/ca-certs/$hash
    cat  /etc/pki/ciao/controller_cert.pem  >> /etc/ca-certs/cacert.pem
fi

# Wait until keystone is ready
source /root/ciaorc
echo "Waiting keystone to start "
until ciao-cli tenant list | grep service > /dev/null 2>&1 ; do
    echo -n .
    sleep 1
done
# Starging ciao-controller
$GOBIN/ciao-controller -logtostderr -ceph_id=$CEPH_ID -v=3

