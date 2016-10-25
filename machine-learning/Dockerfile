FROM clearlinux
MAINTAINER marcos.simental.magana@intel.com

ARG swupd_args

RUN swupd bundle-add machine-learning-basic R-basic R-basic

RUN rm -rf /var/lib/swupd

CMD 'bash'
