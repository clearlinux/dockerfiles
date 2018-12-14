FROM clearlinux
MAINTAINER otc-swstacks@intel.com

ARG swupd_args

COPY setup_mkl.sh /

RUN swupd update $swupd_args && \
		swupd bundle-add curl git && \
		/setup_mkl.sh && \
		rm setup_mkl.sh

CMD 'bash'
