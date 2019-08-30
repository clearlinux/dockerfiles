# Clear Linux* OS `mariadb` container image

<!-- Required -->
## What is this image?

`clearlinux/mariadb` is a Docker image with `mariadb` running on top of the
[official clearlinux base image](https://hub.docker.com/_/clearlinux). 

<!-- application introduction -->
> [Mariadb](https://mariadb.com/) is a community-developed, commercially supported 
> fork of the MySQL relational database management system (RDBMS), intended to remain 
> free and open-source software under the GNU General Public License. Development is led 
> by some of the original developers of MySQL, who forked it due to concerns over its 
> acquisition by Oracle Corporation

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

*Note: This container uses the same syntax as the [official mariadb image](https://hub.docker.com/_/mariadb).


1. Pull the image from Docker Hub: 
    ```
    docker pull clearlinux/mariadb
    ```

2. Start a container using the examples below:
    ```
    docker run --name clr-mariadbtest -e MYSQL_ROOT_PASSWORD=mypass -d clearlinux/mariadb
    # Get the mariadb server IP
    docker inspect clr-mariadbtest | grep IPAddress
    # Test it
    mysql -h $IP -u root -p
    ```
    
    Environment Variables
    ---------------------
    - ``MYSQL_ROOT_PASSWORD`` specifies MariaDB root password
    
    
    Container Image Size
    ---------------------
    Clear Linux enables the AVX2 instructions compile in default for many applications, including mariadb.
    With the two sets of binaries/libraries as below, this mariadb in Clear Linux can automatically and 
    dynamically choose corresponding set to support different IA platforms.
    
    SSE:
    ```
    /usr/bin/mariadb
    /usr/bin/mariadb-access
    /usr/bin/mariadb-admin
    /usr/bin/mariadb-backup
    ...
    /usr/bin/mysql
    /usr/bin/mysql_client_test
    /usr/bin/mysql_config
    ...
    /usr/lib64/libmariadb.so
    /usr/lib64/libmariadbd.so
    /usr/lib64/libmariadbd.so.19
    ...
    ```
    
    AVX/AVX2:
    ```
    /usr/bin/haswell/mariadb
    /usr/bin/haswell/mariadb-admin
    /usr/bin/haswell/mariadb-backup
    /usr/bin/haswell/mariadb-binlog
    ...
    /usr/bin/haswell/mysql
    /usr/bin/haswell/mysql_client_test
    /usr/bin/haswell/mysql_ldb
    ...
    /usr/lib64/haswell/libmariadb.so
    /usr/lib64/haswell/libmariadbd.so
    /usr/lib64/haswell/libmariadbd.so.19
    ...
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
    cd mariadb/
    ```

3. Build the container image:
    ```
    docker build -t clearlinux/mariadb .
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
