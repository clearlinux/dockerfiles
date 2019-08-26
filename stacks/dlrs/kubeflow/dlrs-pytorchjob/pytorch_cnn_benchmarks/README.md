# Training PyTorch CNN Benchmarks

This directory contains code to train convolutional neural networks using cnn_benchmarks.

## Build Image

The PyTorch Job consumes a custom DLRS image for deployment. The default image name and tag is project-name/stacks-pytorch-kf-mkl:0.4.0; you should change the image name to match your project and make the proper changes in pytorch_job_cnn_benchmarks.yaml.

```bash
docker build -f Dockerfile -t project-name/stacks-pytorch-kf-mkl:0.4.0 .
```
