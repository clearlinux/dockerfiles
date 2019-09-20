FROM clearlinux/stacks-clearlinux:latest
MAINTAINER otc-swstacks@intel.com

RUN swupd bundle-add curl java-runtime python2-basic which pmdk sudo

RUN mkdir workspace
COPY scripts/docker-entrypoint.sh /usr/local/bin/
COPY scripts/docker-healthcheck /usr/local/bin/
COPY scripts/change_fsdax_perms.sh /usr/local/bin/
COPY scripts/change_devdax_perms.sh /usr/local/bin/
COPY scripts/change_persistent_dirs_perms.sh /usr/local/bin/

#Adding sudo in order to take ownership of PMEM devices, sudoers file should be deleted
#once the permissions are granted on docker-entrypoint.sh
RUN  useradd cassandra-user && \
     mkdir -p /etc/sudoers.d && \
     echo 'cassandra-user ALL=(root) NOPASSWD: /usr/local/bin/change_fsdax_perms.sh,/usr/local/bin/change_devdax_perms.sh,/usr/local/bin/change_persistent_dirs_perms.sh' > /etc/sudoers.d/cassandra-user

RUN  chown root:root /usr/local/bin/change_fsdax_perms.sh && \
     chmod 755 /usr/local/bin/change_fsdax_perms.sh && \
     chown root:root /usr/local/bin/change_devdax_perms.sh && \
     chmod 755 /usr/local/bin/change_devdax_perms.sh && \
     chown root:root /usr/local/bin/change_persistent_dirs_perms.sh && \
     chmod 755 /usr/local/bin/change_persistent_dirs_perms.sh


COPY cassandra-pmem-build.tar.gz /tmp
RUN  cd /tmp && \
     tar zxvf cassandra-pmem-build.tar.gz && \
     mkdir -p /workspace/cassandra/build && \
     cp -r /tmp/cassandra/bin /workspace/cassandra && \
     cp -r /tmp/cassandra/conf /workspace/cassandra && \
     cp -r /tmp/cassandra/lib /workspace/cassandra && \
     cp -r /tmp/cassandra/pylib /workspace/cassandra && \
     cp -r /tmp/cassandra/tools /workspace/cassandra && \
     cp -r /tmp/cassandra/build/classes /workspace/cassandra/build && \
     cp /tmp/cassandra/build/apache-cassandra-4.0-alpha2-SNAPSHOT.jar /workspace/cassandra/build && \
     cd /workspace && \
     rm -rf /tmp/cassandra && \
     rm /tmp/cassandra-pmem-build.tar.gz && \
     chown root:root -R /workspace && \
     mkdir /workspace/cassandra/data && \
     mkdir /workspace/cassandra/logs && \
     chown cassandra-user -R /workspace/cassandra/data && \
     chown cassandra-user -R /workspace/cassandra/logs && \
     chmod 0755 /workspace/cassandra/bin/* && \
     rm -rf /workspace/cassandra/lib/sigar-bin/*.dll && \
     rm -rf /workspace/cassandra/lib/sigar-bin/*.lib && \
     rm /workspace/cassandra/conf/cassandra.yaml && \
     rm /workspace/cassandra/conf/jvm-server.options && \
     rm /workspace/cassandra/conf/jvm8-server.options && \
     rm /workspace/cassandra/conf/jvm11-server.options


COPY conf/cassandra-template.yaml /workspace/cassandra/conf/
COPY conf/jvm-server.options-template /workspace/cassandra/conf/
COPY conf/jvm8-server.options /workspace/cassandra/conf/
COPY conf/jvm11-server.options /workspace/cassandra/conf/
RUN chown cassandra-user -R /workspace/cassandra/conf/

RUN swupd bundle-remove curl
RUN swupd clean

HEALTHCHECK --interval=30s CMD ["docker-healthcheck"]

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
USER cassandra-user
CMD ["/workspace/cassandra/bin/cassandra", "-f"]
