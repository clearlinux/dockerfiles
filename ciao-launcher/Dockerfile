FROM clearlinux/ciao-common
MAINTAINER obed.n.munoz@intel.com

ARG swupd_args

COPY *.sh  /root/
COPY dnsmasq.conf.macvlan0  /etc/dnsmasq.conf

CMD '/root/launcher.sh'
