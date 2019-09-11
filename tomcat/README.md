# Clear Linux* OS `tomcat` container image

<!-- Required -->
## What is this image?

`clearlinux/tomcat` is a Docker image with `tomcat` running on top of the
[official clearlinux base image](https://hub.docker.com/_/clearlinux). 

<!-- application introduction -->
> [Tomcat](http://tomcat.apache.org/) is an open source implementation of the Java Servlet, 
> JavaServer Pages, Java Expression Language and Java WebSocket technologies. 

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

*Note: This container uses the same syntax as the [official tomcat image](https://hub.docker.com/_/tomcat).


1. Pull the image from Docker Hub: 
    ```
    docker pull clearlinux/tomcat
    ```

2. Start a container using the examples below:

    ```
    docker run --rm -it --hostname my-tomcat --name some-tomcat -p 8080:8080 clearlinux/tomcat
    ```
    

<!-- Optional -->
### Deploy with Kubernetes

This image can also be deployed on a Kubernetes cluster, such as [minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).The following example YAML files are provided in the repository as reference for Kubernetes deployment:

- [`tomcat-deployment.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/tomcat/tomcat-deployment.yaml): example using default configuration to create a basic tomcat service.

- [`tomcat-deployment-index-custom.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/tomcat/tomcat-deployment-index-custom.yaml): example using your own custom index html to create a tomcat service.

- [`tomcat-deployment-conf-custom.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/tomcat/tomcat-deployment-conf-custom.yaml): example using your own custom configuration to create a tomcat service.

  

Steps to deploy tomcat on a Kubernetes cluster:

1. If you want to deploy `tomcat-deployment.yaml`

   ```
   kubectl create -f tomcat-deployment.yaml
   ```

   Or if you want to deploy `tomcat-deployment-index-custom.yaml`

   ```
   kubectl create -f tomcat-deployment-index-custom.yaml
   ```

   Or if you want to deploy `tomcat-deployment-conf-custom.yaml`

   ```
   kubectl create -f tomcat-deployment-conf-custom.yaml
   ```

2. Navigate to [http://\<nodeIP\>:30001](http://\<nodeIP\>:30001) in your browser, where 30001 is the port number defined in your service.



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
    cd tomcat/
    ```

3. Build the container image:
    ```
    docker build -t clearlinux/tomcat .
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
