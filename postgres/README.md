# Clear Linux* OS `postgres` container image

<!-- Required -->
## What is this image?

`clearlinux/postgres` is a Docker image with `postgres` running on top of the
[official clearlinux base image](https://hub.docker.com/_/clearlinux). 

<!-- application introduction -->
> [PostgreSQL](https://www.postgresql.org/) is a powerful, open source object-relational 
> database system with over 30 years of active development that has earned it a strong 
> reputation for reliability, feature robustness, and performance. 

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
## Environment Variables
The PostgreSQL image uses several environment variables which are easy to miss. While none of the variables are required, they may significantly aid you in using the image.

Warning: the Docker specific variables will only have an effect if you start the container with a data directory that is empty; any pre-existing database will be left untouched on container startup.

### POSTGRES_PASSWORD
This environment variable is recommended for you to use the PostgreSQL image. This environment variable sets the superuser password for PostgreSQL. The default superuser is defined by the POSTGRES_USER environment variable.

Note 1: The PostgreSQL image sets up trust authentication locally so you may notice a password is not required when connecting from localhost (inside the same container). However, a password will be required if connecting from a different host/container.

Note 2: This variable defines the superuser password in the PostgreSQL instance, as set by the initdb script during inital container startup. It has no effect on the PGPASSWORD environment variable that may be used by the psql client at runtime, as described at https://www.postgresql.org/docs/10/static/libpq-envars.html. PGPASSWORD, if used, will be specified as a separate environment variable

### POSTGRES_USER
This optional environment variable is used in conjunction with POSTGRES_PASSWORD to set a user and its password. This variable will create the specified user with superuser power and a database with the same name. If it is not specified, then the default user of postgres will be used.

### POSTGRES_DB
This optional environment variable can be used to define a different name for the default database that is created when the image is first started. If it is not specified, then the value of POSTGRES_USER will be used.

### POSTGRES_INITDB_ARGS

This optional environment variable can be used to send arguments to postgres initdb. The value is a space separated string of arguments as postgres initdb would expect them. This is useful for adding functionality like data page checksums: -e POSTGRES_INITDB_ARGS="--data-checksums".

### POSTGRES_INITDB_WALDIR

This optional environment variable can be used to define another location for the Postgres transaction log. By default the transaction log is stored in a subdirectory of the main Postgres data folder (PGDATA). Sometimes it can be desireable to store the transaction log in a different directory which may be backed by storage with different performance or reliability characteristics.

### PGDATA

This optional variable can be used to define another location - like a subdirectory - for the database files. The default is /var/lib/postgresql/data, but if the data volume you're using is a filesystem mountpoint (like with GCE persistent disks), Postgres initdb recommends a subdirectory (for example /var/lib/postgresql/data/pgdata ) be created to contain the data.

This is an environment variable that is not Docker specific. Because the variable is used by the postgres server binary (see the [PostgreSQL docs](https://www.postgresql.org/docs/11/app-postgres.html#id-1.9.5.14.7)), the entrypoint script takes it into account.

<!-- Required -->
## Deployment:

### Deploy with Docker
The easiest way to get started with this image is by simply pulling it from
Docker Hub. 

*Note: This container uses the same syntax as the [official postgres image](https://hub.docker.com/_/postgres).


1. Pull the image from Docker Hub: 
    ```
    docker pull clearlinux/postgres
    ```

2. Start a container using the examples below:

    ```
    docker run -p 5432:5432 -e POSTGRES_PASSWORD=secret -d clearlinux/postgres
    ```

<!-- Optional -->
### Deploy with Kubernetes

This image can also be deployed on a Kubernetes cluster, such as [minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).The following example YAML files are provided in the repository as reference for Kubernetes deployment:

- [`postgres-deployment.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/postgres/postgres-deployment.yaml): example using default configuration with secret to create a basic postgres service.
- [`postgres-deployment-conf.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/postgres/postgres-deployment-conf.yaml): example using your own custom configuration with secret to create  postgres service.



Steps to deploy Postgres on a Kubernetes cluster:

1. Create secret for postgres service.

   ```
   kubectl create secret generic postgres-config \
   --from-literal=POSTGRES_DB=<your-postgres-db> \
   --from-literal=POSTGRES_PASSWORD=<your-postgres-pwd> \
   --from-literal=POSTGRES_USER=<your-postgres-user>
   ```

2. If you want to deploy `postgres-deployment.yaml` 

   ```
   kubectl create -f postgres-deployment.yaml
   ```

   Or if you want to deploy `postgres-deployment-conf.yaml` 

   ```
   kubectl create -f postgres-deployment-conf.yaml
   ```

3. Install PostgreSQL bundle and connect to the service, where 30001 is the port number defined in your service.

   ```
   swupd bundle-add postgresql
   psql -h<nodeIP> -U<your-postgres-user> --password -p30001 <your-postgres-db>
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
    cd postgres/
    ```

3. Build the container image:
    ```
    docker build -t clearlinux/postgres .
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
