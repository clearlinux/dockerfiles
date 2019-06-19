#!/bin/sh
set -e

# use mirror ftp if inside intel
if [[ $http_proxy =~ "intel.com" ]]; then
    swupd bundle-add wget -u http://linux-ftp.jf.intel.com/pub/mirrors/clearlinux/update/
else
    swupd bundle-add wget
fi

wget http://www.phoronix-test-suite.com/benchmark-files/pybench-2018-02-16.tar.gz
tar -xvf pybench-2018-02-16.tar.gz
cd pybench-2018-02-16
python3 pybench.py
