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

3. Customize OPCache parameters via environment variable, for example:
   ```
   docker run -it -e "OPCACHE_ENABLE_CLI=1" clearlinux/php
   ```
   *Note: please get all environment variable setting from  below OPCache parameters section.*

<!-- Optional -->
### Deploy with Kubernetes

<!-- Optional -->
### OPCache Configurations
The OPCache parameters for PHP container could be configed via following environment variable.
These values will be set into /usr/share/defaults/php/php.ini.

* **OPCACHE_ENABLE_CLI**
   - Default Value: 1
   - Config in php.ini: opcache.enable_cli
   - Descriptions:
     Enables the opcode cache for the CLI version of PHP. When testing/debugging or
     run **PHPBench**, set 1

* **OPCACHE_VALIDATE_TIMESTAMPS**
   - Default Value: 0
   - Config in php.ini: opcache.validate_timestamps
   - Descriptions:
     If enabled, OPcache will check for updated scripts every opcache.revalidate_freq seconds.
     If the source of workload is cloned by git via sidecar design pattern and will be updated
     often, set 1

* **OPCACHE_REVALIDATE_FREQ**
   - Default Value: 0
   - Config in php.ini: opcache.revalidate_freq
   - Descriptions:
     How often to check script timestamps for updates, in seconds. 0 will result in
     OPcache checking for updates on every request.

* **OPCACHE_INTERNED_STRINGS_BUFFER**
   - Default Value: 16
   - Config in php.ini: opcache.interned_strings_buffer
   - Descriptions:
     The amount of memory used to store interned strings, in megabytes.

* **OPCACHE_OPTIMIZATION_LEVEL**
   - Default Value: 0x7FFFFFFF
   - Config in php.ini: opcache.optimization_level
   - Descriptions:
     A bitmask that controls which optimisation passes are executed.

* **OPCACHE_MEMORY_CONSUMPTION**
   - Default Value: 256
   - Config in php.ini: opcache.memory_consumption
   - Descriptions:
     The size of the shared memory storage used by OPcache, in megabytes.
     You can use the function opcachegetstatus() to tell how much memory opcache
     is consuming and if you need to increase the amount

* **OPCACHE_MAX_ACCELERATED_FILES**
   - Default Value: 10000
   - Confg in php.ini: opcache.max_accelerated_files
   - Descriptions:
     Controls how many PHP files, at most, can be held in memory at once. It's important
     that your project has LESS FILES than whatever you set this at.
     You can run `find . -type f -print | grep php | wc -l` to quickly calculate the number
     of files in your codebase.

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

4. Please refer to [create custom application container image](https://docs.01.org/clearlinux/latest/guides/maintenance/container-image-modify.html) on how to customize your container image with specific debug capabilities, such as: make, git.

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
