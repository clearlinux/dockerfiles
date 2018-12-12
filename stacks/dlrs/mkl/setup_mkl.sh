#!/bin/bash
set -e

MINCONDA_VERSION="4.5.11"

echo "Downloading miniconda..."
curl -k -L --fail https://repo.anaconda.com/miniconda/Miniconda3-${MINCONDA_VERSION}-Linux-x86_64.sh \
    -o ~/miniconda.sh 2>/dev/null || { echo "Failed to download MiniConda..."; }
/bin/bash ~/miniconda.sh -b -p /opt/conda && rm ~/miniconda.sh
mkdir -p /etc/profile.d && \
    ln -s -f /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    source ~/.bashrc
# create an env and install Tensorflow
echo "Installing Tensorflow with MKL..."
conda create -y -n tf_env tensorflow nltk && \
    echo "export PATH=/opt/conda/envs/tf_env/bin:$PATH" >> ~/.bashrc && \
    echo "conda activate tf_env" >> ~/.bashrc
ln -s -f /opt/conda/envs/tf_env/bin/python /usr/bin/python
