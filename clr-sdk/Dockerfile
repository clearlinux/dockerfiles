FROM clearlinux:latest
MAINTAINER kevin.c.wells@intel.com

ARG swupd_args

COPY setup.py /usr/bin/setup.py

# Update and add bundles
RUN swupd update $swupd_args && \
    swupd bundle-add os-clr-on-clr $swupd_args && \
    chmod 755 /usr/bin/setup.py

ENTRYPOINT ["/usr/bin/setup.py"]

