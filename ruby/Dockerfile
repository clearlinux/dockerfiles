FROM clearlinux:latest
MAINTAINER hongzhan.chen@intel.com

RUN swupd update --no-boot-update $swupd_args && \
    swupd bundle-add ruby-basic $swupd_args
RUN rm -rf /var/lib/swupd

CMD ["irb"]
