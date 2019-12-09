FROM openfaas/classic-watchdog:0.18.1 as watchdog

FROM clearlinux:base

ARG swupd_args

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

# Add non root user
RUN useradd app

RUN mkdir -p /root/function
WORKDIR /root/function/

# install bundles if required
# PLEASE input bundle line by line
COPY function/bundles.txt  .
RUN for bundle in $(cat bundles.txt); do \
        swupd bundle-add $bundle $swupd_args; \
    done


WORKDIR /home/app

USER app

# Populate example here - i.e. "cat", "sha512sum" or "node index.js"
ENV fprocess="cat"
# Set to true to see request in function logs
ENV write_debug="false"

EXPOSE 8080

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]
