## Database Reference Stack with Redis

[![](https://images.microbadger.com/badges/image/clearlinux/stacks-dbrs-redis.svg)](http://microbadger.com/images/clearlinux/stacks-dbrs-redis "Get your own image badge on microbadger.com")

### Building Locally

The Dockerfiles for all Clear Linux* OS based container images are available at [dockerfiles repository](https://github.com/clearlinux/dockerfiles). These can be used to build and modify the container images.

1. Clone the clearlinux/dockerfiles repository.

    ```bash
    git clone https://github.com/clearlinux/dockerfiles.git
    ```

2. Change to the directory of the application:

    ```bash
    cd dockerfiles/stacks/dbrs/redis
    ```

3. Build the container image. Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg

    ```bash
    docker build --no-cache -t clearlinux/stacks-dbrs-redis .
    ```

### Clone the repository



### Run DBRS Redis as a standalone container

Prior to start the application, you will need to have the DCPMM in fsdax mode with a file system and mounted in `/mnt/dax0`. To know how to configure, read the [DBRS guide](https://docs.01.org/clearlinux/latest/guides/stacks/dbrs.html)

To start the application

```bash
docker run --mount type=bind,source=/mnt/dax0,target=/mnt/pmem0 -i -d --name pmem-redis ${DOCKER_IMAGE} --nvm-maxcapacity 200 --nvm-dir /mnt/pmem0 --nvm-threshold 64 --protected-mode no
```

### Deploy DBRS Redis cluster on Kubernetes

#### Kubernetes installation

To install Kubernetes in Clear Linux, follow the instructions in the Clear Linux's [Kubernetes Tutorial](https://docs.01.org/clearlinux/latest/tutorials/kubernetes.html)

After setting up Kubernetes, you will need to enable it to support DCPMM suing the pmem-csi driver. To install the driver follow the instructions in the [pmem-csi repository](https://github.com/intel/pmem-csi) file.

#### Redis operator install

The source code of the redis operator can be found in this [repository](https://github.com/spotahome/redis-operator).

To install the operator, go to you kubernetes control plane and execute the following command:

```bash
kubectl create -f https://raw.githubusercontent.com/spotahome/redis-operator/master/example/operator/all-redis-operator-resources.yaml
```

#### Redis operator usage

After installing the operator you are ready to deploy redisfailover instances using a yaml file, there is an example for persistent memory [here](https://github.com/spotahome/redis-operator/blob/master/example/redisfailover/pmem.yaml). You can download it and change the source of the image to clearlinux/stacks-dbrs-redis. We have created our own yaml based on this example, you can find it in this repo with the name: `redis-failover.yml`

In the `redis-failover.yml` there is a placeholder for the image name, substitute the word `PMEM_REDIS_IMAGE` with the name of the clearlinux/stacks-dbrs-redis image.

To start a redisfailover instance in Kubernetes using our yaml, move the file to the kubernetes server, then run:

```bash
kubectl create -f redis-failover.yml
```

##### Known issues

There is an issue of the sentinels not having enough memory to create the InitContainer. The issue has been reported [here](https://github.com/spotahome/redis-operator/issues/176). The current workaround is to build the image increasing the limits for the InitContainer memory to 32Mb

**Note**
If you already have a redis-operator, you will need to delete it before installing a new one.
