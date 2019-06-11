FROM clearlinux:latest
MAINTAINER hongzhan.chen@intel.com

#Install apache-flink bundle
RUN swupd update --no-boot-update $swupd_args
RUN swupd bundle-add apache-flink $swupd_arg \
        && rm -rf /var/lib/swupd/*

# Configure Flink version
ENV FLINK_VERSION=1.7.2

# Prepare environment
ENV FLINK_HOME=/usr/share/flink
ENV PATH=$FLINK_HOME/bin:$PATH

# Prepare to run
RUN mkdir -p /var/log/flink

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 6123 8081
CMD ["help"]
