# Docker image for running examples in Tensorflow models.
FROM clearlinux/stacks-dlrs-mkl:1390

RUN mkdir -p /opt
RUN git clone --depth 1 https://github.com/tensorflow/benchmarks.git /opt/tf-benchmarks

COPY launcher.py /opt
RUN chmod u+x /opt/*
ENTRYPOINT ["/opt/launcher.py"]
