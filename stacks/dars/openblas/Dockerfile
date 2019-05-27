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


# start: OpenBLAS specific
ENV OPENBLAS_AVX512=/usr/lib64/haswell/avx512_1/libopenblas_skylakexp-r0.3.5.so

# TODO: remove this softlinks once CLR team fix it
RUN swupd bundle-add --skip-diskspace-check \
    python-basic-dev && \
    ln -sf ${OPENBLAS_AVX512} /usr/lib64/haswell/libblas.so && \
    ln -sf ${OPENBLAS_AVX512} /usr/lib64/haswell/libblas.so.3 && \
    ln -sf ${OPENBLAS_AVX512} /usr/lib64/haswell/liblapack.so && \
    ln -sf ${OPENBLAS_AVX512} /usr/lib64/haswell/liblapack.so.3 && \
    ldconfig

CMD ["/bin/sh"]
