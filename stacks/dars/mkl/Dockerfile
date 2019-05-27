FROM clearlinux
LABEL maintainer="otc-swstacks@intel.com"

ARG swupd_args

WORKDIR /root

# ldconfig configuration
COPY dars.ld.so.conf .
RUN cat dars.ld.so.conf >> /etc/ld.so.conf

# OS update and bundle installation
RUN swupd update $swupd_args && \
    swupd bundle-add --skip-diskspace-check \
    big-data-basic \
    which

COPY profile /etc/profile


# start: MKL specific
ENV MKL_INSTALLER=http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/15095/l_mkl_2019.2.187_online.tgz
ENV MKL_WRAPPER=https://github.com/Intel-bigdata/mkl_wrapper_for_non_CDH/raw/master
ENV MKL_TARGET_DIR=/opt/intel/mkl/wrapper

COPY silent.cfg .
RUN swupd bundle-add curl cpio && \
    curl ${MKL_INSTALLER} -o l_mkl.tgz && \
    mkdir l_mkl && \
    tar -xvf l_mkl.tgz -C l_mkl --strip-components=1 && \
    l_mkl/install.sh -s silent.cfg && \
    rm -rf l_mkl && \
    mkdir -p ${MKL_TARGET_DIR} && \
    curl -L ${MKL_WRAPPER}/mkl_wrapper.jar -o ${MKL_TARGET_DIR}/mkl_wrapper.jar && \
    curl -L ${MKL_WRAPPER}/mkl_wrapper.so  -o ${MKL_TARGET_DIR}/mkl_wrapper.so && \
    ldconfig

CMD ["/bin/sh"]
