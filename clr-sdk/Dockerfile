FROM clearlinux:latest
MAINTAINER kevin.c.wells@intel.com

ARG swupd_args

COPY setup.py /usr/bin/setup.py
COPY clruser /usr/share/defaults/sudo/sudoers.d/

# Update and add bundles
RUN swupd update $swupd_args && \
    swupd bundle-add os-clr-on-clr $swupd_args && \
    chmod 755 /usr/bin/setup.py && \
    chmod 440 /usr/share/defaults/sudo/sudoers.d/clruser

ENTRYPOINT ["/usr/bin/setup.py"]

