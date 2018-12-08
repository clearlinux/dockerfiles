# Docker image for running examples in Tensorflow models.
# base_image depends on whether we are running on GPUs or non-GPUs
FROM hub.docker.com/clearlinux/stacks-dlrs-oss:latest

RUN mkdir -p /opt
RUN swupd bundle-add go-basic
RUN git clone https://github.com/tensorflow/benchmarks.git /opt/tf-benchmarks

COPY launcher.py /opt
RUN chmod u+x /opt/launcher.py

ENTRYPOINT ["/opt/launcher.py"]
