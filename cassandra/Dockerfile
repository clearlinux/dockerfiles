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
# Remove openjdk src package to optimize docker image size
RUN source /os-release && \
    mkdir /install_root \
    && swupd os-install -V ${VERSION_ID} \
    --path /install_root --statedir /swupd-state \
    --bundles=cassandra,os-core-plus,su-exec --no-boot-update \
    && rm /install_root/usr/lib/jvm/*/src.zip

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

ENV CASSANDRA_CONFIG /usr/share/cassandra/conf
ENV PATH /usr/share/cassandra/bin:/usr/share/cassandra/tools/bin:$PATH

RUN mkdir -p /var/lib/cassandra/{cdc_raw,commitlog,data,hints,saved_caches}  \
        && chown -R cassandra:cassandra /var/lib/cassandra "$CASSANDRA_CONFIG" \
        && chmod -R 777 /var/lib/cassandra /usr/share/cassandra/tools/bin "$CASSANDRA_CONFIG"
VOLUME /var/lib/cassandra

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh 

ENTRYPOINT ["docker-entrypoint.sh"]

# 7000: intra-node communication
# 7001: TLS intra-node communication
# 7199: JMX
# 9042: CQL
# 9160: thrift service
EXPOSE 7000 7001 7199 9042 9160
CMD ["cassandra", "-f"]
