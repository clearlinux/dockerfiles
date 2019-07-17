FROM clearlinux
MAINTAINER marcos.simental.magana@intel.com

ARG swupd_args

RUN swupd update --no-boot-update $swupd_args \
    && swupd bundle-add machine-learning-basic R-basic R-extras \
    && rm -rf /var/lib/swupd

CMD 'bash'
