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


RUN swupd bundle-add --skip-diskspace-check \
    python-basic-dev

# TODO: remove this softlinks once CLR team fix it
ENV OPENBLAS_AVX512 /usr/lib64/haswell/avx512_1/libopenblas_skylakexp-r0.3.5.so
RUN ln -sf ${OPENBLAS_AVX512} /usr/lib64/haswell/libblas.so && \
		ln -sf ${OPENBLAS_AVX512} /usr/lib64/haswell/libblas.so.3 && \
		ln -sf ${OPENBLAS_AVX512} /usr/lib64/haswell/liblapack.so && \
		ln -sf ${OPENBLAS_AVX512} /usr/lib64/haswell/liblapack.so.3

RUN ldconfig

CMD ["/bin/bash"]
