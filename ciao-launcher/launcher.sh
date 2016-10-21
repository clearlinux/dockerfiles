#!/bin/bash
set -x

# Copy images
mkdir -p /var/lib/ciao/images
if [ ! "$(ls -A /var/lib/ciao/images)" ]; then
    cp -r /share/images/* /var/lib/ciao/images/
fi

# compile the code before running it
go install github.com/01org/ciao/...
cp -f $GOBIN/* /usr/bin

# Starting Compute Service
mkdir -p /var/lib/misc
mkdir -p /var/run

killall -9 dnsmasq
dnsmasq -C /etc/dnsmasq.conf

$GOBIN/ciao-launcher -logtostderr -v=3
