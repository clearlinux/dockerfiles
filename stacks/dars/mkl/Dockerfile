FROM clearlinux
LABEL maintainer="otc-swstacks@intel.com"

ARG swupd_args

# OS update and bundle installation
RUN swupd update $swupd_args && \
    swupd bundle-add --skip-diskspace-check \
    big-data-basic \
    which

# general settings for all derived images
WORKDIR /root

# ldconfig configuration
COPY dars.ld.so.conf .
RUN cat dars.ld.so.conf >> /etc/ld.so.conf

# copy spark-core jar
COPY spark-core_2.12-2.4.0.jar /usr/share/apache-spark/jars/spark-core_2.12-2.4.0.jar


RUN swupd bundle-add curl cpio

# mkl
COPY silent.cfg .
RUN curl http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/15095/l_mkl_2019.2.187_online.tgz -o l_mkl.tgz
RUN mkdir l_mkl && tar -xvf l_mkl.tgz -C l_mkl --strip-components=1 && \
    l_mkl/install.sh -s silent.cfg && rm -rf l_mkl

# mkl wrapper
RUN mkdir -p /opt/intel/mkl/wrapper && \
    curl -L https://github.com/Intel-bigdata/mkl_wrapper_for_non_CDH/raw/master/mkl_wrapper.jar -o /opt/intel/mkl/wrapper/mkl_wrapper.jar && \
    curl -L https://github.com/Intel-bigdata/mkl_wrapper_for_non_CDH/raw/master/mkl_wrapper.so -o /opt/intel/mkl/wrapper/mkl_wrapper.so

RUN ldconfig

CMD ["/bin/bash"]
