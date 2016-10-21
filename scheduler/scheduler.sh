#!/bin/bash
set -x

IDENTITY_HOST="${IDENTITY_HOST:-localhost}"

sed -i.bak s/IDENTITY_HOST/$IDENTITY_HOST/g /etc/ciao/configuration.yaml

# compile the code before running it
go install github.com/01org/ciao/...
cp -f $GOBIN/* /usr/bin

# Starting Scheduler
$GOBIN/ciao-scheduler --cacert=/etc/pki/ciao/CAcert-ciao-dev.pem --cert=/etc/pki/ciao/cert-Scheduler-ciao-dev.pem --heartbeat
