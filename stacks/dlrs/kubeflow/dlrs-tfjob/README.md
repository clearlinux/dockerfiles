# TensorFlow Training (TFJob) with Kubeflow and DLRS

A [TFJob](https://www.kubeflow.org/docs/components/tftraining) is Kubeflow's custom resource used to run TensorFlow training jobs on Kubernetes.

## Submitting TFJobs

In this folder you will find TFJob examples that use the Deep Learning Reference Stack as base image for creating the container(s) that will run training workloads in your Kubernetes cluster.
Select one form the list below:

* [Training Tensorflow CNN Benchmarks with DLRS + Intel® MKL-DNN and AVX512-DL Boost](https://github.com/clearlinux/dockerfiles/tree/master/stacks/dlrs/kubeflow/dlrs-tfjob/tf_cnn_benchmarks)

For further information, please refer to:
* [Distributed TensorFlow](https://www.tensorflow.org/deploy/distributed).
* [TFJobs](https://www.kubeflow.org/docs/components/tftraining/)
