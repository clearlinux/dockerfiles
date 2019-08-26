FROM clearlinux/stacks-pytorch-mkl:v0.4.0

WORKDIR /var
COPY cnn_benchmarks.py /var

ENTRYPOINT ["mpirun", "-n", "1", "--allow-run-as-root", "python", "/var/cnn_benchmarks.py"]
