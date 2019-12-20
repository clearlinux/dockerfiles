FROM clearlinux

ARG swupd_args

RUN swupd update --no-boot-update $swupd_args \
    && swupd bundle-add machine-learning-web-ui \
    && rm -rf /var/lib/swupd/*

EXPOSE 8888

CMD ["jupyter-notebook"]

COPY jupyter_notebook_config.py /etc/jupyter/
