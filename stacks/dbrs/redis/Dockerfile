FROM clearlinux AS build-redis
MAINTAINER otc-swstacks@intel.com

RUN swupd bundle-add --quiet --no-progress git c-basic devpkg-ndctl os-testsuite-phoronix-server

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
