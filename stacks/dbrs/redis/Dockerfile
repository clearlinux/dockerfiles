FROM clearlinux AS build-redis
MAINTAINER otc-swstacks@intel.com

RUN swupd bundle-add --quiet --no-progress git c-basic devpkg-ndctl curl package-utils

RUN clr_ver=$(grep VERSION_ID /usr/lib/os-release | awk -F= '{print $2}') && \
	NUMA_DEV="https://cdn.download.clearlinux.org/releases/$clr_ver/clear/x86_64/os/Packages/numactl-dev-2.0.12-20.x86_64.rpm" && \
	NUMA_LIB="https://cdn.download.clearlinux.org/releases/$clr_ver/clear/x86_64/os/Packages/numactl-lib-2.0.12-20.x86_64.rpm" && \
	rpm -ihv --nodeps $NUMA_DEV $NUMA_LIB

RUN  useradd redis-user

ENV REDIS_PMEMD="/tmp/redis"
ENV EXTRA_CFLAGS=" -Wno-error"
RUN  git clone https://github.com/pmem/pmem-redis $REDIS_PMEMD && \
     cd $REDIS_PMEMD && \
     git submodule init && git submodule update && \
     make USE_NVM=yes install

FROM clearlinux/os-core:latest

RUN useradd redis-user

COPY scripts/docker-entrypoint.sh scripts/docker-healthcheck /usr/bin/
COPY --from=build-redis /usr/bin/ps /usr/bin/
COPY --from=build-redis /usr/local/bin/* /usr/bin/
COPY --from=build-redis /usr/lib64/libnuma.so* /usr/lib64/libprocps.so* /usr/lib64/

HEALTHCHECK --interval=15s CMD ["docker-healthcheck"]

ENTRYPOINT ["docker-entrypoint.sh"]
USER redis-user
CMD echo "USE: redis-server --nvm-maxcapacity <size> --nvm-dir <persistent mount point> --nvm-threshold <threshold to move to PMEM>" && redis-server --help
