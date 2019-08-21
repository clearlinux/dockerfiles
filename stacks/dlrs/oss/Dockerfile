ARG clear_ver
FROM stacks-clearlinux:$clear_ver

# FIXME: Until Moby finds a way for saving ARGs in multi-stage builds (see https://github.com/moby/moby/issues/34129)
# we have to re-declare clear_ver
ARG clear_ver
ARG swupd_args=$clear_ver
LABEL maintainer=otc-swstacks@intel.com

RUN swupd update -m $swupd_args && swupd bundle-add curl sysadmin-basic devpkg-gperftools \
    git machine-learning-tensorflow \
    && ln -s /usr/lib64/libtcmalloc.so /usr/lib/libtcmalloc.so

# install additional python packages for ipython and jupyter notebook
RUN pip --no-cache-dir install ipython ipykernel matplotlib jupyter && \
    python -m ipykernel.kernelspec

CMD 'bash'
