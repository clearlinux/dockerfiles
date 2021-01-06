FROM openfaas/classic-watchdog:0.18.1 as watchdog

FROM clearlinux/python:3

ARG swupd_args
RUN swupd bundle-add python-extras $swupd_args

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

RUN useradd numpy-func
WORKDIR /home/numpy-func

COPY function /home/numpy-func/function
WORKDIR /home/numpy-func/function
# pip install python packages if required
RUN pip install --no-cache-dir -r requirements.txt

# install bundles if required
# PLEASE input bundle line by line
RUN for bundle in $(cat bundles.txt); do \
        swupd bundle-add $bundle $swupd_args; \
    done

# give a chance to run help script
RUN chmod +x helper_script.sh && ./helper_script.sh
RUN chmod +x numpy-entry.sh && chmod +x set-num-threads.sh \
    && chown numpy-func -R /home/numpy-func \
    && mkdir /usr/local/bin \
    && mv numpy-entry.sh /usr/local/bin \
    && mv set-num-threads.sh /usr/local/bin

USER numpy-func
ENV fprocess="numpy-entry.sh"
EXPOSE 8080

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]
