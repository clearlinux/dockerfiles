
# Deep Learning Reference Stack


We are pleased to announce the initial release of the Deep Learning Reference Stack.

The Deep Learning Reference Stack is optimized for Intel® Architecture (IA) from the hardware to the end-use applications and solutions.  The stack has been tuned, tested and validated for Intel platforms to power a growing range of AI workloads. This reference stack makes it easier for developers and Cloud Service Providers to build deep learning models by reducing the complexity that comes with cutting-edge work.


# The Deep Learning Reference Stack Release


To offer more flexibility, we are releasing two versions of the Deep Learning Reference Stack:  a version that includes TensorFlow* optimized for Intel® Architecture, the "Eigen" version, and a second version that includes the TensorFlow* framework optimized using Intel® Math Kernel Library for Deep Neural Networks, the "Intel® MKL-DNN" version.

> **Note:**
     Clear Linux will be automatically updated to the latest release in the container.  The minimum validated version of Clear Linux for this stack is 26240

> **Note:**
> For multi-node support, we include a registry with a set of jsonnet files to show integration with Kubeflow for deployment.

## The Deep Learning Reference Stack with Eigen


The release includes:
  * Clear Linux* OS
  * TensorFlow 1.12 compiled with AVX2 and AVX512 optimizations
  * Runtimes (python)

## The Deep Learning Reference Stack with Intel® MKL-DNN


The release includes:
  * Clear Linux* OS
  * Runtimes (python)
  * TensorFlow 1.12 optimized using Intel® Math Kernel Library for Deep Neural Networks (Intel® MKL-DNN) primitives.


## How to get the Deep Learning Reference Stack

The official Deep Learning Reference Stack Docker images are hosted at: https://hub.docker.com/u/clearlinux/.

 * Pull from the [Eigen version](https://hub.docker.com/r/clearlinux/stacks-dlaas-oss/)
 * Pull from the [Intel MKL-DNN version](https://hub.docker.com/r/clearlinux/stacks-dlaas-mkl/)

> **Note:**
   The OSS version of the image will use the latest version of Clear Linux.

## Licensing


The Deep Learning Reference Stack is guided by the same [Terms of Use](https://download.clearlinux.org/TermsOfUse.html) declared by the Clear Linux project. The Docker images are hosted on https://hub.docker.com and as with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc. from the base distribution, along with any direct or indirect dependencies of the primary software being contained).



# Working with the Deep Learning Reference Stack


The Deep Learning Reference Stack includes TensorFlow and Kubeflow support.
These software components were selected because they are most popular/widely used by developers and CSPs. Clear Linux provides optimizations across the entire OS stack for the ultimate end user performance and is customizable to meet your unique needs. TensorFlow was selected as it is the leading deep learning and machine learning framework. Intel® Math Kernel Library for Deep Neural Networks (Intel® MKL-DNN) is an open source performance library for Deep Learning (DL) applications intended for acceleration of DL frameworks on Intel® architecture. Intel® MKL-DNN includes highly vectorized and threaded building blocks to implement convolutional neural networks (CNN) with C and C++ interfaces.  Kubeflow  is a project that provides a straightforward way to deploy simple, scalable and portable Machine Learning workflows on Kubernetes. This combination of an operating system, the deep learning framework and libraries, results in a performant deep learning software stack.

Please refer to the [Deep Learning tutorial](https://clearlinux.org/documentation/clear-linux/tutorials/dlaas.rst) for detailed instructions for running the TensorFlow and Kubeflow Benchmarks on the docker images.

## Performance tuning configurations

### Single Node Configuration

| Key | Value |
| ----------------- | ------------- |
| num_inter_threads | Socket number |
| num_intra_threads | Physical cores number |
| data_format       |  NHWC for Eigen; NCHW for MKL as MKL is optimized for this format |


Example: For Intel® Xeon® Gold 6140 CPU @ 2.30GHz with 2 Sockets and 18 Cores/Socket MKL training with batch size 32:

```
  python tf_cnn_benchmarks.py --device=cpu --mkl=True --nodistortions --model=resnet50 --data_format=NCHW --batch_size=32 --num_inter_threads=2 --num_intra_threads=36 --data_dir=/imagenet-TFrecord --data_name=imagenet
```
### Multi Node Configuration
With Kubernetes + Tensorflow, a simple configuration would be: 1 master + 3 slave (master does not apply for real workloads execution) 1 parameter server + 2 worker (each deployed on a K8s slave)

| Key | Value |
|----- | ------ |
| num_inter_threads | Socket number |
| num_intra_threads | Physical cores number (Reserve 2 cores per socket for IO operations) |
| data_format | NHWC for Eigen; NCHW for MKL as MKL is optimized for this format |


Example: For Intel® Xeon® Gold 6140 CPU @ 2.30GHz based systems with 2 Sockets and 18 Cores/Socket, 2-node distributed MKL dstraining with 1 worker per node and 1 Parameter Server (PS) can be specified and launched with this [TFJob](https://github.com/clearlinux/dockerfiles/blob/master/stacks/dlaas/kubeflow/dlaas-tfjob/dlaas-bench/prototypes/dlaas-resnet50.jsonnet)

```
 PS:
                args: [
                  "python",
                  "tf_cnn_benchmarks.py",
                  "--mkl=True",
                  "--nodistortions",
                  "--batch_size=128",
                  "--model=resnet50",
                  "--num_inter_threads=2",
                  "--num_intra_threads=32",
                  "--variable_update=parameter_server",
                  "--local_parameter_device=cpu",
                  "--init_learning_rate=0.0001",
                  "--tf_random_seed=8286",
                  "--device=cpu",
                  "--data_format=NCHW",
                  "--data_dir=/imagenet/",
                  "--data_name=imagenet",
                ]

 Worker:
               args: [
                  "python",
                  "tf_cnn_benchmarks.py",
                  "--mkl=True",
                  "--nodistortions",
                  "--batch_size=128",
                  "--model=resnet50",
                  "--num_inter_threads=2",
                  "--num_intra_threads=32",
                  "--variable_update=parameter_server",
                  "--local_parameter_device=cpu",
                  "--init_learning_rate=0.0001",
                  "--tf_random_seed=8286",
                  "--device=cpu",
                  "--data_format=NCHW",
                  "--data_dir=/imagenet/",
                  "--data_name=imagenet",
                ]
```

For further notes on performance tuning use Tensorflow’s [official performance guide](https://www.tensorflow.org/guide/performance/overview)


# Contributing to the Deep Learning Reference Stack

We encourage your contributions to this project, through the established Clear Linux community tools.  Our team uses typical open source collaboration tools that are described on the Clear Linux [community page](https://clearlinux.org/community).



# Reporting Security Issues

  If you have discovered a potential security vulnerability in an Intel open-source product, please contact the Intel OSSIRT (Open Source Security Incident Response Team) at secure-opensource@intel.com.

  It is important to include the following details:

  * The projects and versions affected
  * Repository and home page links for the affected projects
  * Detailed description of the vulnerability
  * Information on known exploits

  Vulnerability information is extremely sensitive. The OSSIRT strongly recommends that all security vulnerability reports sent to Intel be encrypted using the OSSIRT PGP key. The PGP key is available here:  https://01.org/node/9721

  Software to encrypt messages may be obtained from:

  * PGP Corporation
  * GnuPG
