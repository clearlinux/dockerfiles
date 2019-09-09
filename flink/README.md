# Clear Linux* OS `flink` container image

<!-- Required -->
## What is this image?

`clearlinux/flink` is a Docker image with `flink` running on top of the
[official clearlinux base image](https://hub.docker.com/_/clearlinux). 

<!-- application introduction -->
> [Flink](http://flink.apache.org/) is a framework and distributed processing engine 
> for stateful computations over unbounded and bounded data streams. Flink has been 
> designed to run in all common cluster environments, perform computations at in-memory 
> speed and at any scale.

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

*Note: This container uses the same syntax as the [official flink
image](https://hub.docker.com/_/flink).


1. Pull the image from Docker Hub: 
    ```
    docker pull clearlinux/flink
    ```

2. Start a container using the examples below:

    ```
    docker run  -d clearlinux/flink
    ```
    

<!-- Optional -->
### Deploy with Kubernetes

This image can also be deployed on a Kubernetes cluster, such as [minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).The following example YAML files are provided in the repository as reference for Kubernetes deployment:

- [`flink-deployment.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/flink/flink-deployment.yaml): example using default configuration to create a basic flink service.

- [`flink-deployment-conf.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/flink/flink-deployment-conf.yaml): example using your own custom configuration to create a flink service.

  

Steps to deploy flink on a Kubernetes cluster:

1. If you want to deploy `flink-deployment.yaml`

   ```
   kubectl create -f flink-deployment.yaml
   ```

   Or if you want to deploy `flink-deployment-conf.yaml`  

   ```
   kubectl create -f flink-deployment-conf.yaml
   ```

2. Run kubectl proxy in your terminal.

3. Navigate to [http://\<nodeIP\>:8001/api/v1/namespaces/default/services/flink-jobmanager:ui/proxy](http://\<nodeIP\>:8001/api/v1/namespaces/default/services/flink-jobmanager:ui/proxy) in your browser. 

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
    cd flink/
    ```

3. Build the container image:
    ```
    docker build -t clearlinux/flink .
    ```

   Refer to the Docker documentation for [default build
   arguments](https://docs.docker.com/engine/reference/builder/#arg).
   Additionally:
   
   - `swupd_args` - specifies arguments to pass to the Clear Linux* OS software
     manager. See the [swupd man
     pages](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options)
     for more information.

<!-- Required -->
## Licenses

All licenses for the Clear Linux* Project and distributed software can be found
at https://clearlinux.org/terms-and-policies
