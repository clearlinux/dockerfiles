FROM clearlinux:latest
MAINTAINER hongzhan.chen@intel.com

RUN swupd update $swupd_args && \
    swupd bundle-add python3-basic $swupd_args
RUN rm -rf /var/lib/swupd

CMD ["python3"]
