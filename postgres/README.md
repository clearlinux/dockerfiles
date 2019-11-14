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

### On container start
When the container is executed, it will execute the files with extension `.sh` located at `/docker-entrypoint-preinitdb.d` before initializing or starting postgresql.

In order to have your custom files inside the docker image you can mount them as a volume.

### Initializing a new instance
When the container is executed for the first time, it will execute the files with extensions `.sh`, `.sql` and `.sql.gz` located at `/docker-entrypoint-initdb.d`.

In order to have your custom files inside the docker image you can mount them as a volume.


### Persisting your database
If you remove the container all your data and configurations will be lost, and the next time you run the image the database will be reinitialized. To avoid this loss of data, you should mount a volume that will persist even after the container is removed.

For persistence you should mount a directory at the `/clrconf/postgresql` path. If the mounted directory is empty, it will be initialized on the first run.

```bash
$ docker run \
    -v /path/to/postgresql-persistence:/clrconf/postgresql \
    clearlinux/postgres
```

### Setting up a streaming replication
A [Streaming replication](http://www.postgresql.org/docs/9.4/static/warm-standby.html#STREAMING-REPLICATION) cluster can easily be setup with the Clearlinux PostgreSQL Docker Image using the following environment variables:

 - `POSTGRESQL_REPLICATION_MODE`: Replication mode. Possible values `master`/`slave`. No defaults.
 - `POSTGRESQL_REPLICATION_USER`: The replication user created on the master on first run. No defaults.
 - `POSTGRESQL_REPLICATION_PASSWORD`: The replication users password. No defaults.
 - `POSTGRESQL_REPLICATION_PASSWORD_FILE`: Path to a file that contains the replication users password. This will override the value specified in `POSTGRESQL_REPLICATION_PASSWORD`. No defaults.
 - `POSTGRESQL_MASTER_HOST`: Hostname/IP of replication master (slave parameter). No defaults.
 - `POSTGRESQL_MASTER_PORT_NUMBER`: Server port of the replication master (slave parameter). Defaults to `5432`.

In a replication cluster you can have one master and zero or more slaves. When replication is enabled the master node is in read-write mode, while the slaves are in read-only mode. For best performance its advisable to limit the reads to the slaves.

#### Step 1: Create the replication master
The first step is to start the master.

```bash
$ docker run --name postgresql-master \
  -e POSTGRESQL_REPLICATION_MODE=master \
  -e POSTGRESQL_USERNAME=my_user \
  -e POSTGRESQL_PASSWORD=password123 \
  -e POSTGRESQL_DATABASE=my_database \
  -e POSTGRESQL_REPLICATION_USER=my_repl_user \
  -e POSTGRESQL_REPLICATION_PASSWORD=my_repl_password \
  clearlinux/postgres
```

In this command we are configuring the container as the master using the `POSTGRESQL_REPLICATION_MODE=master` parameter. A replication user is specified using the `POSTGRESQL_REPLICATION_USER` and `POSTGRESQL_REPLICATION_PASSWORD` parameters.

#### Step 2: Create the replication slave
Next we start a replication slave container.

```bash
$ docker run --name postgresql-slave \
  --link postgresql-master:master \
  -e POSTGRESQL_REPLICATION_MODE=slave \
  -e POSTGRESQL_MASTER_HOST=master \
  -e POSTGRESQL_MASTER_PORT_NUMBER=5432 \
  -e POSTGRESQL_REPLICATION_USER=my_repl_user \
  -e POSTGRESQL_REPLICATION_PASSWORD=my_repl_password \
  clearlinux/postgres
```

In the above command the container is configured as a `slave` using the `POSTGRESQL_REPLICATION_MODE` parameter. Before the replication slave is started, the `POSTGRESQL_MASTER_HOST` and `POSTGRESQL_MASTER_PORT_NUMBER` parameters are used by the slave container to connect to the master and replicate the initial database from the master. The `POSTGRESQL_REPLICATION_USER` and `POSTGRESQL_REPLICATION_PASSWORD` credentials are used to authenticate with the master. In order to change the `pg_hba.conf` default settings, the slave needs to know if `POSTGRESQL_PASSWORD` is set.

With these two commands you now have a two node PostgreSQL master-slave streaming replication cluster up and running. You can scale the cluster by adding/removing slaves without incurring any downtime.

> **Note**: The cluster replicates the master in its entirety, which includes all users and databases.

If the master goes down you can reconfigure a slave to act as the master and begin accepting writes by creating the trigger file `/tmp/postgresql.trigger.5432`. For example the following command reconfigures `postgresql-slave` to act as the master:

```bash
$ docker exec postgresql-slave touch /tmp/postgresql.trigger.5432
```

> **Note**: The configuration of the other slaves in the cluster needs to be updated so that they are aware of the new master. This would require you to restart the other slaves with `--link postgresql-slave:master` as per our examples.

### Synchronous commits
By default, the slaves instances are configued with asynchronous replication. In order to guarantee more data stability (at the cost of some performance), it is possible to set synchronous commits (i.e. a transaction commit will not return success to the client until it has been written in a set of replicas) using the following environment variables.

  - `POSTGRESQL_SYNCHRONOUS_COMMIT_MODE`: Establishes the type of synchronous commit. The available options are: `on`, `remote_apply`, `remote_write`, `local` and `off`. The default value is `on`. For more information, check the [official PostgreSQL documentation](https://www.postgresql.org/docs/9.6/runtime-config-wal.html#GUC-SYNCHRONOUS-COMMIT).
  - `POSTGRESQL_NUM_SYNCHRONOUS_REPLICAS`: Establishes the number of replicas that will enable synchronous replication. This number must not be above the number of slaves that you configure in the cluster.

### Specifying initdb arguments
Specifying extra initdb arguments can easily be done using the following environment variables:

 - `POSTGRESQL_INITDB_ARGS`: Specifies extra arguments for the initdb command. No defaults.
 - `POSTGRESQL_INITDB_WALDIR`: Defines a custom location for the transaction log. No defaults.

```bash
$ docker run --name postgresql \
  -e POSTGRESQL_INITDB_ARGS="--data-checksums" \
  -e POSTGRESQL_INITDB_WALDIR="/clrconf/waldir" \
  clearlinux/postgres
```
### Environment variables aliases
The Clearlinux PostgreSQL container allows two different sets of environment variables. Please see the list of environment variable aliases in the next table:

| Environment Variable                 | Alias                              |
| :----------------------------------- | :--------------------------------- |
| POSTGRESQL_USERNAME                  | POSTGRES_USER                      |
| POSTGRESQL_DATABASE                  | POSTGRES_DB                        |
| POSTGRESQL_PASSWORD                  | POSTGRES_PASSWORD                  |
| POSTGRESQL_PASSWORD_FILE             | POSTGRES_PASSWORD_FILE             |
| POSTGRESQL_POSTGRES_PASSWORD         | POSTGRES_POSTGRES_PASSWORD         |
| POSTGRESQL_POSTGRES_PASSWORD_FILE    | POSTGRES_POSTGRES_PASSWORD_FILE    |
| POSTGRESQL_PORT_NUMBER               | POSTGRES_PORT_NUMBER               |
| POSTGRESQL_INITDB_ARGS               | POSTGRES_INITDB_ARGS               |
| POSTGRESQL_INITDB_WALDIR             | POSTGRES_INITDB_WALDIR             |
| POSTGRESQL_DATA_DIR                  | PGDATA                             |
| POSTGRESQL_REPLICATION_USER          | POSTGRES_REPLICATION_USER          |
| POSTGRESQL_REPLICATION_MODE          | POSTGRES_REPLICATION_MODE          |
| POSTGRESQL_REPLICATION_PASSWORD      | POSTGRES_REPLICATION_PASSWORD      |
| POSTGRESQL_REPLICATION_PASSWORD_FILE | POSTGRES_REPLICATION_PASSWORD_FILE |
| POSTGRESQL_CLUSTER_APP_NAME          | POSTGRES_CLUSTER_APP_NAME          |
| POSTGRESQL_MASTER_HOST               | POSTGRES_MASTER_HOST               |
| POSTGRESQL_MASTER_PORT_NUMBER        | POSTGRES_MASTER_PORT_NUMBER        |
| POSTGRESQL_NUM_SYNCHRONOUS_REPLICAS  | POSTGRES_NUM_SYNCHRONOUS_REPLICAS  |
| POSTGRESQL_SYNCHRONOUS_COMMIT_MODE   | POSTGRES_SYNCHRONOUS_COMMIT_MODE   |

> *IMPORTANT*: Changing the `POSTGRES_USER` will not change the owner of the database that will continue being the `postgres` user. In order to change the database owner, please access using `postgres` as user (`$ psql -U postgres ...`) and execute the following command:
```
alter database POSTGRES_DATABASE owner to POSTGRES_USER;
```

It is possible to change the user that PostgreSQL will use to execute the init scripts. To do so, use the following environment variables:

| Environment variable           | Description                                                       |
|--------------------------------|-------------------------------------------------------------------|
| POSTGRESQL_INITSCRIPTS_USERNAME | User that will be used to execute the init scripts                |
| POSTGRESQL_INITSCRIPTS_PASSWORD | Password for the user specified in POSTGRESQL_INITSCRIPT_USERNAME |

<!-- Optional -->
## Deploy with Docker Compose

```bash
$ curl -sSL https://github.com/clearlinux/dockerfiles/blob/master/postgres/docker-compose.yml > docker-compose.yml
$ docker-compose up -d
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
