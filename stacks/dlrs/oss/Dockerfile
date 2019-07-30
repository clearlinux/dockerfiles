ARG clear_ver
FROM clearlinux/stacks-clearlinux:$clear_ver

# FIXME: Until Moby finds a way for saving ARGs in multi-stage builds (see https://github.com/moby/moby/issues/34129)
# we have to re-declare clear_ver
ARG clear_ver
ARG swupd_args=$clear_ver
LABEL maintainer=otc-swstacks@intel.com

RUN swupd update -m $swupd_args && swupd bundle-add curl sysadmin-basic \
    git machine-learning-tensorflow

# install additional python packages for ipython and jupyter notebook
RUN pip --no-cache-dir install ipython ipykernel matplotlib jupyter && \
    python -m ipykernel.kernelspec

CMD 'bash'
