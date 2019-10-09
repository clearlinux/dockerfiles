FROM clearlinux:latest AS builder
ARG swupd_args

# Move to latest Clear Linux release to ensure
# that the swupd command line arguments are
# correct
RUN swupd update --no-boot-update $swupd_args && \
    swupd bundle-add curl

# Grab os-release info from the minimal base image so
# that the new content matches the exact OS version
COPY --from=clearlinux/os-core:latest /usr/lib/os-release /

# Install additional content in a target directory
# using the os version from the minimal base
RUN source /os-release && \
    mkdir /install_root \
    && swupd os-install -V ${VERSION_ID} \
    --path /install_root --statedir /swupd-state \
    --bundles=big-data-basic,cpio,os-core-update,which --no-boot-update \
    && rm -rf /install_root/var/lib/swupd/*

# fetch MKL library and wrapper
RUN URL='http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/15816' && \
    MKL_VERSION='l_mkl_2019.5.281_online' && \
    mkdir /install_root/mkl /install_root/mkl_wrapper && \
    curl ${URL}/${MKL_VERSION}.tgz -o /install_root/mkl/${MKL_VERSION}.tgz && \
    tar -xvf /install_root/mkl/${MKL_VERSION}.tgz -C /install_root/mkl --strip-components=1 && \
    curl -L https://github.com/Intel-bigdata/mkl_wrapper_for_non_CDH/raw/master/mkl_wrapper.jar -o /install_root/mkl_wrapper/mkl_wrapper.jar && \
    curl -L https://github.com/Intel-bigdata/mkl_wrapper_for_non_CDH/raw/master/mkl_wrapper.so  -o /install_root/mkl_wrapper/mkl_wrapper.so

# For some Host OS configuration with redirect_dir on,
# extra data are saved on the upper layer when the same
# file exists on different layers. To minimize docker
# image size, remove the overlapped files before copy.
RUN mkdir /os_core_install
COPY --from=clearlinux/os-core:latest / /os_core_install/
RUN find / os_core_install | sed -e 's/os_core_install/install_root/' | xargs rm -d &> /dev/null || true

FROM clearlinux/os-core:latest
LABEL maintainer=otc-swstacks@intel.com

ENV HOME=/root

COPY --from=builder /install_root /
COPY --from=builder /install_root/mkl /mkl

# Configure openjdk11
ENV JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Environment variables to point to Hadoop,
# Spark and YARN installation and configuration
ENV HADOOP_HOME=/usr
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
ENV HADOOP_DEFAULT_LIBEXEC_DIR=$HADOOP_HOME/libexec
ENV HADOOP_IDENT_STRING=root
ENV HADOOP_LOG_DIR=/var/log/hadoop
ENV HADOOP_PID_DIR=/var/log/hadoop/pid
ENV HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"

ENV HDFS_DATANODE_USER=root
ENV HDFS_NAMENODE_USER=root
ENV HDFS_SECONDARYNAMENODE_USER=root

ENV SPARK_HOME=/usr/share/apache-spark
ENV SPARK_CONF_DIR=/etc/spark

ENV YARN_RESOURCEMANAGER_USER=root
ENV YARN_NODEMANAGER_USER=root

COPY dars.ld.so.conf /etc/ld.so.conf
COPY silent.cfg /mkl

RUN /mkl/install.sh -s /mkl/silent.cfg && \   
    ldconfig

COPY --from=builder /install_root/mkl_wrapper/mkl_wrapper.* /opt/intel/mkl/wrapper/

RUN rm -rf /mkl_wrapper /mkl /tmp/*

RUN mkdir -p /etc/spark /etc/hadoop && \
    cp /usr/share/defaults/hadoop/log4j.properties /etc/hadoop && \
    cp /usr/share/apache-spark/conf/log4j.properties.template /etc/spark/log4j.properties

COPY spark_conf/* /etc/spark/
COPY hadoop_conf/* /etc/hadoop/

CMD ["/bin/bash"]
