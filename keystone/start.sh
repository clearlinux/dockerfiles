#!/bin/bash

docker rm -f keystone

YOUR_HOST=onmunoz-arch.zpn.intel.com

rm *.pem

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout keystone_key.pem \
	-out keystone_cert.pem -subj "/CN=$YOUR_HOST"

docker run -d -it --name keystone -p 5000:5000 -p 35357:35357 \
       -e MARIADB_HOST="$YOUR_HOST" \
       -e IDENTITY_HOST="$YOUR_HOST" \
       -e COMPUTE_HOST="$YOUR_HOST" \
       -e KEYSTONE_DB_USER="keystone" \
       -e KEYSTONE_DB_PASSWORD="secret" \
       -e KEYSTONE_DB_NAME="keystone" \
       -e KEYSTONE_ADMIN_PASSWORD="secret" \
       -v `pwd`/keystone_cert.pem:/etc/nginx/ssl/keystone_cert.pem \
       -v `pwd`/keystone_key.pem:/etc/nginx/ssl/keystone_key.pem \
       clearlinux/keystone

#docker logs -f keystone
