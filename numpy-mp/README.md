# Clear Linux* OS `numpy-mp` container image

<!-- Required -->
## What is this image?

`clearlinux/numpy-mp` is a Docker image with `parallelizable numpy` running on top of the
[official clearlinux base image](https://hub.docker.com/_/clearlinux).
It is an optimized and configurable Python-Numpy foundation container with AVX-512 enabled for microservice and FaaS workload for Kubernetes or HPC use cases.

<!-- application introduction -->
> [NumPy](https://numpy.org/) is the fundamental package for scientific computing with Python.
> Clear Linux numpy-mp container can set OMP_NUM_THREADS dynamically at runtime to accelerate
> performance according to assigned computing resources.

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

*Note: This container uses the same syntax as the [official python image](https://hub.docker.com/_/python).


1. Pull the image from Docker Hub:
    ```
    docker pull clearlinux/numpy-mp
    ```

2. Start a container using the examples below:

    ```
    docker run -d clearlinux/numpy-mp
    ```
<!-- Optional -->
### OMP Configurations
The OMP parameters for numpy-mp container could be configured via following environment variable.

* **OMP_NUM_THREADS**
   - Descriptions:
     Specifies the default number of threads to use in parallel regions. If undefined an optimized value will be set at runtime by [docker-entrypoint.sh](https://github.com/clearlinux/dockerfiles/blob/master/numpy-mp/docker-entrypoint.sh).

* **OMP_THREAD_LIMIT**
   - Descriptions:
    Specifies the number of threads to use for the whole program. If undefined, the number of threads is not limited.

* **OMP_DYNAMIC**
   - Descriptions:
     Enable or disable the dynamic adjustment of the number of threads within a team. If undefined, dynamic adjustment is disabled by default.

* **OMP_SCHEDULE**
   - Descriptions:
     Allows to specify schedule type and chunk size. If undefined, dynamic scheduling and a chunk size of 1 is used.

* **OMP_NESTED**
   - Descriptions:
     Enable or disable nested parallel regions, i.e., whether team members are allowed to create new teams. If undefined, nested parallel regions are disabled by default.

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
    cd numpy-mp/
    ```

3. Build the container image:
    ```
    docker build -t clearlinux/numpy-mp .
    ```

4. Please refer to [create custom application container image](https://docs.01.org/clearlinux/latest/guides/maintenance/container-image-modify.html) on how to customize your container image with specific debug capabilities, such as: make, git.

   Refer to the Docker documentation for [default build arguments](https://docs.docker.com/engine/reference/builder/#arg).
   Additionally:

   - `swupd_args` - specifies arguments to pass to the Clear Linux* OS software
     manager. See the [swupd man pages](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options)
     for more information.

<!-- Required -->
## Licenses

All licenses for the Clear Linux* Project and distributed software can be found
at https://clearlinux.org/terms-and-policies
