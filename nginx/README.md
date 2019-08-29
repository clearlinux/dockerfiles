# Clear Linux* OS `nginx` container image

<!-- Required -->
## What is this image?

`clearlinux/nginx` is a Docker image with `nginx` running on top of the
[official clearlinux base image](https://hub.docker.com/_/clearlinux). 

<!-- application introduction -->
> [Nginx](https://www.nginx.com/) (pronounced "engine-x") is an open source
> reverse proxy server for HTTP, HTTPS, SMTP, POP3, and IMAP protocols, as well
> as a load balancer, HTTP cache, and a web server (origin server). 

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

*Note: This container uses the same syntax as the [official nginx
image](https://hub.docker.com/_/nginx). The default root path is
`/var/www/html` and default configuration path is `/etc/nginx/`.* 


1. Pull the image from Docker Hub: 
    ```
    docker pull clearlinux/nginx
    ```

2. Start a container using the examples below:

   * Start with persistent volume for web content:
     ```
     docker run -p 80:80 -v /some/content:/var/www/html -d clearlinux/nginx
     ```

   * Start with an alternative nginx configuration file:
     ```
     docker run -p 80:80 -v /host/path/nginx.conf:/etc/nginx/nginx.conf -d clearlinux/nginx
     ```

<!-- Optional -->
### Deploy with Kubernetes
This image can also be deployed on a Kubernetes cluster, such as
[minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).The
following example YAML template files are provided in the repository as
reference for Kubernetes deployment:

   * [`nginx-service-deployment-simple.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/nginx/nginx-service-deployment-simple.yaml):
     example using default configuration to create a basic nginx service.
   * [`nginx-service-deployment-customize-conf.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/nginx/nginx-service-deployment-customize-conf.yaml):
     example using a customized nginx.conf configuration file to replace
     default one.
   * [`nginx-service-deployment-persistent-volume.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/nginx/nginx-service-deployment-persistent-volume.yaml):
     example using persistent storage for web server content.

To deploy the image on a Kubernetes cluster:

1. Review the contents of the template file and edit appropriately for your
   needs.

2. Apply the YAML template configuration.
    ```
    kubectl apply -f nginx-service-deployment-<xxx>.yaml
    ```

3. Start the service.
    ```
    minikube service clear-nginx-service
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
    cd nginx/
    ```

3. Build the container image:
    ```
    docker build -t clearlinux/nginx .
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
