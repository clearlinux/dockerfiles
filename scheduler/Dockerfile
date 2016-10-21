FROM clearlinux/ciao-common
MAINTAINER obed.n.munoz@intel.com

ARG swupd_args

COPY *.sh  /root/
RUN mkdir /etc/ciao

COPY configuration.yaml /etc/ciao/
COPY ciaorc /root/

CMD '/root/scheduler.sh'
