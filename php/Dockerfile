FROM clearlinux:latest AS builder

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
    --bundles=os-core-update,php-basic --no-boot-update

RUN echo -e '\
opcache.enable_cli=${OPCACHE_ENABLE_CLI}\n\
opcache.memory_consumption=${OPCACHE_MEMORY_CONSUMPTION}\n\
opcache.validate_timestamps=${OPCACHE_VALIDATE_TIMESTAMPS}\n\
opcache.max_accelerated_files=${OPCACHE_MAX_ACCELERATED_FILES}\n\
opcache.optimization_level=${OPCACHE_OPTIMIZATION_LEVEL}\n\
opcache.interned_strings_buffer=${OPCACHE_INTERNED_STRINGS_BUFFER}\n\
opcache.revalidate_freq=${OPCACHE_REVALIDATE_FREQ}' >> /install_root/usr/share/defaults/php/php.ini

# For some Host OS configuration with redirect_dir on,
# extra data are saved on the upper layer when the same
# file exists on different layers. To minimize docker
# image size, remove the overlapped files before copy.
RUN mkdir /os_core_install
COPY --from=clearlinux/os-core:latest / /os_core_install/
RUN cd / && \
    find os_core_install | sed -e 's/os_core_install/install_root/' | xargs rm -d &> /dev/null || true

FROM clearlinux/os-core:latest

ENV OPCACHE_REVALIDATE_FREQ=0 \
    OPCACHE_VALIDATE_TIMESTAMPS=0 \
    OPCACHE_ENABLE_CLI=1 \
    OPCACHE_OPTIMIZATION_LEVEL=0x7FFFFFFF \
    OPCACHE_MEMORY_CONSUMPTION=256 \
    OPCACHE_MAX_ACCELERATED_FILES=10000 \
    OPCACHE_INTERNED_STRINGS_BUFFER=16

COPY --from=builder /install_root /

CMD ["php","-a"]
