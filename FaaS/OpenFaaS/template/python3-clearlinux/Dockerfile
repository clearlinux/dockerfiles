FROM openfaas/classic-watchdog:0.18.1 as watchdog

FROM clearlinux/python:3

ARG swupd_args

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

WORKDIR /root/

COPY index.py           .

RUN mkdir -p function
RUN touch ./function/__init__.py
WORKDIR /root/function/
# pip install python packages if required
COPY function/requirements.txt  .
RUN pip install --no-cache-dir -r requirements.txt

# install bundles if required
# PLEASE input bundle line by line
COPY function/bundles.txt  .
RUN for bundle in $(cat bundles.txt); do \
        swupd bundle-add $bundle $swupd_args; \
    done

# give a chance to run help script
COPY function/helper_script.sh .
RUN chmod +x helper_script.sh && ./helper_script.sh

WORKDIR /root/
COPY function           function

ENV fprocess="python3 index.py"
EXPOSE 8080

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]
