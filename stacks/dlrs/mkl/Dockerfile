FROM clearlinux
MAINTAINER otc-swstacks@intel.com

ARG swupd_args

RUN swupd update $swupd_args && \
	swupd bundle-add devpkg-openmpi git sysadmin-basic

# install miniconda
ADD https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh /miniconda.sh
RUN sh /miniconda.sh -b -p /opt/conda && \
    /opt/conda/bin/conda update -n base conda && \
    rm /miniconda.sh
ENV PATH=${PATH}:/opt/conda/bin

# create tf_env and install tensorflow with mkl-dnn
SHELL ["/bin/bash", "-c"]
RUN conda create -n tf_env
RUN conda install -n tf_env -y -c anaconda \
    pip tensorflow nltk ipython

# add conda env script to bashrc
RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate tf_env" >> ~/.bashrc

# install horovod
RUN source ~/.bashrc
RUN mv /opt/conda/envs/tf_env/compiler_compat/ld /opt/conda/envs/tf_env/compiler_compat/ld.orig
RUN HOROVOD_WITH_TENSORFLOW=1 /opt/conda/envs/tf_env/bin/pip install --no-cache-dir horovod
RUN mv /opt/conda/envs/tf_env/compiler_compat/ld.orig /opt/conda/envs/tf_env/compiler_compat/ld

# install additional python packages for ipython and jupyter
RUN /opt/conda/envs/tf_env/bin/pip install --no-cache-dir ipython ipykernel matplotlib jupyter && \
   /opt/conda/envs/tf_env/bin/python -m ipykernel.kernelspec

CMD ["/bin/bash"]
