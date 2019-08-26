# Training Tensorflow CNN Benchmarks with DLRS + Intel® MKL-DNN and AVX512-DL Boost

This directory contains code to train convolutional neural networks using [tf_cnn_benchmarks](https://github.com/tensorflow/benchmarks/tree/master/scripts/tf_cnn_benchmarks).

> Source: [Training TF CNN models](https://github.com/kubeflow/kubeflow/tree/v0.5-branch/tf-controller-examples/tf-cnn)

## Build Image

The TFJob consumes a custom DLRS image for deployment. The default image name and tag is project-name/stacks-dlrs-kf-mkl; you should change the image name to match your project and make the proper changes in tf_job_cnn_benchmarks.yaml.

```bash
docker build -f Dockerfile -t project-name/stacks-dlrs-kf-mkl:0.4.0 .
```
