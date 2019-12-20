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

ENV PATH $PATH:/usr/libexec/postgresql11
ENV PGDATA /var/lib/pgsql/data
RUN sed -i "s|#listen_addresses.*|listen_addresses = '*'|" /usr/share/postgresql11/postgresql.conf.sample && \
    mkdir -p /run/postgresql11 && chown -R postgres:postgres /run/postgresql11 && \
    mkdir -p "$PGDATA" && chown -R postgres:postgres "$PGDATA" && \
    mkdir /docker-entrypoint-initdb.d && \
    mkdir -p /usr/local/bin

VOLUME /var/lib/pgsql/data
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh && \
    ln -s /usr/local/bin/docker-entrypoint.sh / && \
    ln -s /usr/share/postgresql11 /usr/share/postgresql

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
