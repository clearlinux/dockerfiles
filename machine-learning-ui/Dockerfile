FROM clearlinux
MAINTAINER william.douglas@intel.com

ARG swupd_args

RUN swupd update $swupd_args
RUN swupd bundle-add machine-learning-web-ui

RUN rm -rf /var/lib/swupd

EXPOSE 8888

CMD ["jupyter-notebook"]

COPY jupyter_notebook_config.py /etc/jupyter/
