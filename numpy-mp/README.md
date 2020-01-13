# Clear Linux* OS `numpy-mp` container image

<!-- Required -->
## What is this image?

`clearlinux/numpy-mp` is a Docker image with `parallelizable numpy` running on top of the
[official clearlinux base image](https://hub.docker.com/_/clearlinux).
It is built with AVX-512 optimized Clear Linux content and adaptive OpenMP multithreading strategy for Kubernetes. It is with consideration of the factors impacting performance including Kubernetes CPU quota, number of CPU cores, SIMD AVX-512/AVX2 active cores, and active OpenMP threads. With this solution, CPU active cores are reduced with higher performance achieved at the same time on a Kubernetes cluster.
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
### Deploy with Kubernetes
This image can also be deployed on a Kubernetes cluster, such as
[minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/). The
following example YAML file is provided in the repository as
reference for Kubernetes deployment:

   * [`numpy-mp-demo-deployment.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/numpy-mp/numpy-mp-demo-deployment.yaml):
     yaml file to deploy the numpy-mp workload example

To deploy the image on a Kubernetes cluster:

   * Start the numpy-mp workload example.
     ```
     kubectl apply -f numpy-mp-demo-deployment.yaml
     ```

   * Then check if the pods are running well.
     ```
     kubectl get pods -o wide
     ```
     This may take some time because it requires downloading the image.
     Note, if your cluster is behind some proxy, you may need set the proxy
     environment in the yaml file.

   * Get the workload result
     ```
     kubectl logs --follow=true -f deployment/numpy-mp-deploy
     ```

### OpenMP Configurations
The OMP parameters for numpy-mp container could be configured via following environment variable.

* **OMP_NUM_THREADS**
   - Descriptions:
     Specifies the default number of threads to use in parallel regions. If undefined, an optimized value will be set by the adaptive strategy script [set-num-threads.sh](https://github.com/clearlinux/dockerfiles/blob/master/numpy-mp/set-num-threads.sh). This script is called by [docker-entrypoint.sh](https://github.com/clearlinux/dockerfiles/blob/master/numpy-mp/docker-entrypoint.sh) at container start.
     Alternatively, the user may explicitly set its value in either the Docker run command or in the Kubernetes yaml file, according to the application scenario. For example, if the developer splits the workload from application layer into multiple processes, the OpenMP threads can be set to 1.

* **OMP_THREAD_LIMIT**
   - Descriptions:
     Specifies the number of threads to use for the whole program. If undefined, the number of threads is not limited.

* **OMP_DYNAMIC**
   - Descriptions:
     Enable or disable the dynamic adjustment of the number of threads within a team. If undefined, dynamic adjustment is disabled by default.

* **OMP_SCHEDULE**
   - Descriptions:
     Specifies schedule type and chunk size. If undefined, dynamic scheduling and a chunk size of 1 is used.

* **OMP_NESTED**
   - Descriptions:
     Enable or disable nested parallel regions, such as whether team members are allowed to create new teams. If undefined, nested parallel regions are disabled by default.

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
