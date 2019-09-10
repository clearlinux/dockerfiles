# Clear Linux* OS `php-fpm` container image

<!-- Required -->
## What is this image?

`clearlinux/php-fpm` is a Docker image with `php-fpm` running on top of the
[official clearlinux base image](https://hub.docker.com/_/clearlinux). 

<!-- application introduction -->
> [PHP-FPM](https://php-fpm.org/) (PHP- FastCGI Process Manager) is an alternative 
> PHP FastCGI implementation with some additional features useful for sites of 
> any size, especially busier sites.

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

*Note: This container uses the same syntax as the [official php-fpm
image](https://hub.docker.com/_/php).


1. Pull the image from Docker Hub: 
    ```
    docker pull clearlinux/php-fpm
    ```

2. Start a container using the examples below:

     ```
     docker run --name some-php-fpm clearlinux/php-fpm
     ```

<!-- Optional -->
### Deploy with Kubernetes
This image can also be deployed on a Kubernetes cluster, such as
[minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).The
following example YAML files are provided in the repository as
reference for Kubernetes deployment:

   * [`pv-local.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/php-fpm/pv-local.yaml), [`pvc-local.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/php-fpm/pvc-local.yaml):
     local persistent volumes for php-fpm and redis.
   * [`php-fpm-deployment.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/php-fpm/php-fpm-deployment.yaml):
     deployment for php-fpm + nginx.
   * [`redis-deployment.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/php-fpm/redis-deployment.yaml):
     deployment for redis.

The example utilies nginx, php-fpm and redis containers. All are Clear Linux
published ones on [official clearlinux base
image](https://hub.docker.com/_/clearlinux).
To deploy the image on a Kubernetes cluster you have two volumes configuration
choices:

   * Use local volume to support single-node k8s usage.
     ```
     kubectl apply -f pv-local.yaml
     kubectl apply -f pvc-local.yaml
     ```
Once the volumes got created, you can continue the php+redis
deployment.

1. Deploy redis and php-fpm.
   ```
   kubectl apply -f php-fpm-deployment.yaml
   kubectl apply -f redis-deployment.yaml
   ```

2. Then check if the pods are running well.
   ```
   kubectl get pods -o wide
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
    cd php-fpm/
    ```

3. Build the container image:
    ```
    docker build -t clearlinux/php-fpm .
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
