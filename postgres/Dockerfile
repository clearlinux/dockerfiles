FROM clearlinux:latest AS builder
MAINTAINER william.douglas@intel.com

ARG swupd_args
# Move to latest Clear Linux release to ensure
# that the swupd command line arguments are
# correct
RUN swupd update --no-boot-update $swupd_args

# Grab os-release info from the minimal base image so
# that the new content matches the exact OS version
COPY --from=clearlinux/os-core:latest /usr/lib/os-release /

# Install additional content in a target directory
# using the os version from the minimal base
RUN source /os-release && \
    mkdir /install_root \
    && swupd os-install -V ${VERSION_ID} \
    --path /install_root --statedir /swupd-state \
    --bundles=postgresql11,su-exec --no-boot-update

# For some Host OS configuration with redirect_dir on,
# extra data are saved on the upper layer when the same
# file exists on different layers. To minimize docker
# image size, remove the overlapped files before copy.
RUN mkdir /os_core_install
COPY --from=clearlinux/os-core:latest / /os_core_install/
RUN cd / && \
    find os_core_install | sed -e 's/os_core_install/install_root/' | xargs rm -d &> /dev/null || true

FROM clearlinux/os-core:latest

COPY --from=builder /install_root /

RUN mkdir -p /etc/postgresql11
COPY rootfs /

RUN /postunpack.sh

VOLUME [ "/clrconf/postgresql", "/docker-entrypoint-initdb.d", "/docker-entrypoint-preinitdb.d" ]

RUN sed -i "s|#listen_addresses.*|listen_addresses = '*'|" /usr/share/postgresql11/postgresql.conf.sample

EXPOSE 5432

#USER 1001
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/run.sh"]
