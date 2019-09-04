# Clear Linux* OS `memcached` container image

<!-- Required -->
## What is this image?

`clearlinux/memcached` is a Docker image with `memcached` running on top of the
[official clearlinux base image](https://hub.docker.com/_/clearlinux). 

<!-- application introduction -->
> [memcached](https://memcached.org/) is a free & open source, high-performance, distributed memory object caching system, 
> generic in nature, but intended for use in speeding up dynamic web applications by alleviating database load.

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

*Note: This container uses the same syntax as the [official memcached
image](https://hub.docker.com/_/memcached).  

1. Pull the image from Docker Hub:
    ```
    docker pull clearlinux/memcached
    ```
2. Start a memcached server 
    ```
    docker run --network somenetwork --name memcached-server -d clearlinux/memcached
    ```



<!-- Optional -->

### Deploy with Kubernetes

This image can also be deployed on a Kubernetes cluster, such as [minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).The following example YAML files are provided in the repository as reference for Kubernetes deployment:

- [`memcached-deployment.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/memcached/memcached-deployment.yaml): example using default configuration to create a basic memcached service.

- [`memcached-deployment-conf.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/memcached/memcached-deployment-conf.yaml): example using your own custom configuration to create a  memcached service.

  

Steps to deploy memcached on a Kubernetes cluster:

1. If you want to deploy `memcached-deployment.yaml`

   ```
   kubectl create -f memcached-deployment.yaml
   ```

   Or if you want to deploy `memcached-deployment-conf.yaml`

   ```
   kubectl create -f memcached-deployment-conf.yaml
   ```

2. Install telnet bundle and connect to the service, where 30100 is the port number defined in your service.

   ```
   swupd bundle-add netkit-telnet
   telnet <nodeIP> 30100
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
    cd memcached/
    ```

3. Build the container image:
    ```
    docker build -t clearlinux/memcached .
    ```

   Refer to the Docker documentation for [default build
   arguments](https://docs.docker.com/engine/reference/builder/#arg).
   Additionally:
   
   - `swupd_args` - specifies arguments to pass to the Clear Linux* OS software
     manager. See the [swupd man
     pages](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options)
     for more information.

<!-- Optional -->
## Benchmark test: 
[memtier_benchmark](https://github.com/RedisLabs/memtier_benchmark) is a high throughput benchmarking tool for memcache protocols
1. Pull the benchmark from redislabs:
    ```
    docker pull redislabs/memtier_benchmark
    ```
2. Run memtier benchmark test:  
    ```
    docker run --rm --network somenetwork redislabs/memtier_benchmark ./memtier_benchmark --server=memcached-server -p 11211 -P memcache_text
    ```

<!-- Required -->
## Licenses

All licenses for the Clear Linux* Project and distributed software can be found
at https://clearlinux.org/terms-and-policies