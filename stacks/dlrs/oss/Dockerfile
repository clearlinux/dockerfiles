FROM clearlinux
MAINTAINER otc-swstacks@intel.com

ARG swupd_args

RUN swupd update $swupd_args && \
		swupd bundle-add curl sysadmin-basic \
        git machine-learning-tensorflow

# install additional python packages for ipython and jupyter notebook
RUN pip --no-cache-dir install ipython ipykernel matplotlib jupyter && \
    python -m ipykernel.kernelspec

CMD 'bash'
