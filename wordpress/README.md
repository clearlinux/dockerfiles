# Clear Linux* OS `wordpress` container image

<!-- Required -->
## What is this image?

`clearlinux/wordpress` is a Docker image with `wordpress` running on top of the
[official clearlinux base image](https://hub.docker.com/_/clearlinux).

<!-- application introduction -->
> [wordpress](https://en.wikipedia.org/wiki/WordPress) is a free and open source
> blogging tool and a content management system (CMS) based on PHP and MySQL,
> which runs on a web hosting service.

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

*Note: This container is compatible with the [official wordpress
image (fpm tag)](https://hub.docker.com/_/wordpress). It usually works together
with containers mysql(mariadb) and nginx.


1. Pull the image from Docker Hub:
    ```
    docker pull clearlinux/wordpress
    ```

2. Start wordpress using the examples below:

   * Use docker-compose to start the wordpress/nginx/mariadb in one-shot:
     ```
     docker-compose up
     ```
     The configuration is defined in the
     [`docker-compose.yml`](docker-compose.yml)

   * List wordpress containers info:
     ```
     docker container ls
     
     CONTAINER ID     IMAGE                       PORTS                  NAMES

     eff987d8f6e9     clearlinux/nginx:latest     0.0.0.0:8080->80/tcp   wordpress_nginx_1
     738f71a6e7fa     clearlinux/wordpress:latest 9000/tcp               wordpress_wordpress_1
     deaa8614ce8d     clearlinux/mariadb:latest   3306/tcp               wordpress_db_1
     ```

3. Edit web/blog in wordpress:
   Open one brower to connect the wordpress blog with URL below.
   ```
   http://host-ipaddr:8080/wp-login.php
   ```

<!-- Optional -->
### Deploy with Kubernetes
This image can also be deployed on a Kubernetes cluster, such as
[minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).The
following example YAML files are provided in the repository as
reference for Kubernetes deployment:

   * [`pv-local.yaml`](pv-local.yaml):
     persistent volume for wordpress.
   * [`mysql-deployment.yaml`](mysql-deployment.yaml):
     database deployment for wordpress.
   * [`wordpress-deployment.yaml`](wordpress-deployment.yaml):
     example wordpress plus nginx as web server.
   * [`kustomization.yaml`](kustomization.yaml):
     pack above together as the one-shot resource yaml file to deploy wordpress. 

The example utilies nginx, mariadb and wordpress containers. All are Clear Linux
published ones on [official clearlinux base
image](https://hub.docker.com/_/clearlinux).
To deploy the image on a Kubernetes cluster you can simply run:
   ```
   kubectl apply -k .
   ```

1. Check if the pods are running well.
   ```
   kubectl get pods -o wide
   ```

2. Get wordpress PORT and IP
   ```
   kubectl get -o jsonpath="{.spec.ports[0].nodePort}" services wordpress
   kubectl get nodes -o jsonpath="{.items[0].status.addresses[0].address}"
   ```

3. Edit web/blog in wordpress:
   Open one brower to connect the wordpress blog with PORT and IP got on step 2.
   ```
   http://$IP:$PORT
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
    cd wordpress/
    ```

3. Build the container image:
    ```
    docker build -t clearlinux/wordpress .
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
