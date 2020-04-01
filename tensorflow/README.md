# Clear Linux* OS `tensorflow` container image

<!-- Required -->
## What is this image?
`clearlinux/tensorflow` is a Docker image with `tensorflow` running on top of the
[official clearlinux base image](https://hub.docker.com/_/clearlinux). It is built with AVX-512 optimized Clear Linux content and dynamic multithreading strategy for Kubernetes. It is with consideration of the factors impacting performance including Kubernetes CPU quota, number of CPU cores, SIMD AVX-512/AVX2 active cores, and active threads. With this solution, CPU active cores are reduced with higher performance achieved at the same time on a Kubernetes cluster.

<!-- application introduction -->
> [Tensorflow](https://github.com/tensorflow/tensorflow) is an open-source machine learning library 
> for research and production.

For other Clear Linux* OS
based container images, see: https://hub.docker.com/u/clearlinux

## Why use a clearlinux based image?

<!-- CL introduction -->
> [Clear Linux* OS](https://clearlinux.org/) is an open source, rolling release
> Linux distribution optimized for performance and security, from the Cloud to
> the Edge, designed for customization, and manageability.

Clear Linux* OS based container images use:
* Optimized libraries that are compiled with latest compiler versions and
  flags.
* Software packages that follow upstream source closely and update frequently.
* An aggressive security model and best practices for CVE patching.
* A multi-staged build approach to keep a reduced container image size.
* The same container syntax as the official images to make getting started
  easy. 

To learn more about Clear Linux* OS, visit: https://clearlinux.org.

<!-- Required -->
## Deployment:

### Deploy with Docker
The easiest way to get started with this image is by simply pulling it from
Docker Hub. 

*Note: This container uses the same syntax as the [official tensorflow image](https://hub.docker.com/r/tensorflow/tensorflow).


1. Pull the image from Docker Hub: 
    ```
    docker pull clearlinux/tensorflow
    ```

2. Start a container using the examples below:

    ```
    docker run -it --rm clearlinux/tensorflow bash
    ```
### Run workload in the container
The TF_NUM_THREADS environment variable is set by docker-entrypoint.sh of the container. It can be used as optimized value for intra_op_parallelism_threads when running tensorflow workload. For example:
```
python tf_cnn_benchmarks.py --device=cpu --num_intra_threads=${TF_NUM_THREADS} --data_format=NHWC --batch_size=32 --model=resnet50 --variable_update=parameter_server
```


<!-- Required -->
## Build and modify:

The Dockerfiles for all Clear Linux* OS based container images are available at
https://github.com/clearlinux/dockerfiles. These can be used to build and
modify the container images.

1. Clone the clearlinux/dockerfiles repository.
    ```
    git clone https://github.com/clearlinux/dockerfiles.git
    ```

2. Change to the directory of the application:
    ```
    cd tensorflow/
    ```

3. Build the container image:
    ```
    docker build -t clearlinux/tensorflow .
    ```

   Refer to the Docker documentation for [default build arguments](https://docs.docker.com/engine/reference/builder/#arg).
   Additionally:
   
   - `swupd_args` - specifies arguments to pass to the Clear Linux* OS software
     manager. See the [swupd man pages](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options)
     for more information.

<!-- Required -->
## Licenses

All licenses for the Clear Linux* Project and distributed software can be found
at https://clearlinux.org/terms-and-policies
