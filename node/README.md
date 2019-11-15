# Clear Linux* OS `node` container image

<!-- Required -->
## What is this image?

`clearlinux/node` is a Docker image with `node` running on top of the
[official clearlinux base image](https://hub.docker.com/_/clearlinux). 

<!-- application introduction -->
> [Node](https://nodejs.org/en/) is a JavaScript runtime built on Chrome's V8 JavaScript engine.

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

*Note: This container uses the same syntax as the [official node image](https://hub.docker.com/_/node).


1. Pull the image from Docker Hub: 
    ```
    docker pull clearlinux/node
    ```

2. Start a container using the examples below:

    ```
    docker run -it --rm clearlinux/node
    ```
    

<!-- Optional -->
### Deploy with Kubernetes

This image can also be deployed on a Kubernetes cluster, such as [minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).The following example YAML files are provided in the repository as reference for Kubernetes deployment:

- [`node-deployment.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/node/node-deployment.yaml): example to provide a basic HTTP service.



Steps to deploy node on a Kubernetes cluster:

1. Deploy node-deployment.yaml

   ```
   kubectl create -f node-deployment.yaml
   ```

2. Connect to the service, where 30001 is the port number defined in your service.

   ```
   curl <nodeIP>:30001
   ```

### Environment variables

When you start the node image, you can adjust the configuration of the instance by passing the environment variable on the docker run command line. Manual execution add a -e option with the variable and value:
   ```
   docker run -it -e NAME="some-node" --rm clearlinux/node
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
    cd node/
    ```

3. Build the container image:
    ```
    docker build -t clearlinux/node .
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
