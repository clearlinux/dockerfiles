FROM openfaas/classic-watchdog:0.18.1 as watchdog

FROM clearlinux/python:3

ARG swupd_args

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

WORKDIR /root/

COPY index.py           .
# pip install python packages if required
COPY requirements.txt   .
RUN pip install -r requirements.txt

# install bundles if required
# PLEASE input bundle line by line
COPY bundles.txt  .
RUN for bundle in $(cat bundles.txt); do \
        swupd bundle-add $bundle $swupd_args; \
    done

RUN mkdir -p function
RUN touch ./function/__init__.py
WORKDIR /root/function/
# pip install python packages if required
COPY function/requirements.txt  .
RUN pip install -r requirements.txt

# install bundles if required
# PLEASE input bundle line by line
COPY function/bundles.txt  .
RUN for bundle in $(cat bundles.txt); do \
        swupd bundle-add $bundle $swupd_args; \
    done

WORKDIR /root/
COPY function           function

ENV fprocess="python3 index.py"
EXPOSE 8080

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]
