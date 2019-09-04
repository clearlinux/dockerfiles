# Clear Linux* OS `php` container image

<!-- Required -->
## What is this image?

`clearlinux/php` is a Docker image with `php` running on top of the
[official clearlinux base image](https://hub.docker.com/_/clearlinux). 

<!-- application introduction -->
> [PHP](https://www.php.net/) (Hypertext Preprocessor) is a general-purpose 
> programming language originally designed for web development.the PHP reference 
> implementation is now produced by The PHP Group.PHP originally stood for Personal 
> Home Page, but it now stands for the recursive initialism PHP: Hypertext Preprocessor

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

*Note: This container uses the same syntax as the [official php
image](https://hub.docker.com/_/php).


1. Pull the image from Docker Hub: 
    ```
    docker pull clearlinux/php
    ```

2. Start a container using the examples below:
    ```
    docker run -it --rm --name my-running-php clearlinux/php
    ```

<!-- Optional -->
### Deploy with Kubernetes

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
    cd php/
    ```

3. Build the container image:
   
   * Build clearlinux basic php image
    ```
    docker build -t clearlinux/php .
    ```

   * Create a Dockerfile in your own php project and build:
    ```
    FROM clearlinux/php:latest
    COPY . /usr/src/myphpapp
    WORKDIR /usr/src/myphpapp
    CMD [ "php", "./my-script.php" ]
    ```
    
    ```
    docker build -t my-own-php-instance .
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
