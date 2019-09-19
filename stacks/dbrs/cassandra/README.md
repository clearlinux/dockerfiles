## Database Reference Stack with Cassandra

[![](https://images.microbadger.com/badges/image/clearlinux/stacks-dbrs-cassandra.svg)](http://microbadger.com/images/clearlinux/stacks-dbrs-cassandra "Get your own image badge on microbadger.com")

### Building Locally

The Dockerfiles for all Clear Linux* OS based container images are available at [dockerfiles repository](https://github.com/clearlinux/dockerfiles). These can be used to build and modify the container images.

1. Clone the clearlinux/dockerfiles repository.

    ```bash
    git clone https://github.com/clearlinux/dockerfiles.git
    ```

2. Change to the directory of the application:

    ```bash
    cd dockerfiles/stacks/dbrs/cassandra
    ```

3. Inside this repository there is a file called `scripts/build-cassandra-pmem.sh`, this script handles all the required procedures in rder to have cassandra-pmem compiled and ready for Dockerfile usage. The dependencies for this build can be installed with `swupd`.

    ```bash
    swupd bundle-add c-basic java-basic devpkg-pmdk pmdk
    ```

4. Once installed, we run the script

    ```bash
    ./scripts/build-cassandra-pmem.sh
    ```

5. If everything runs sucessfully you will have a file called `cassandra-pmem-build.tar.gz` on the directory on which you run the script, this file should be placed in the same directory of the Dockerfile for this one to be able to build the docker image sucesfully. Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg

    ```bash
    docker build --no-cache -t clearlinux/stacks-dbrs-cassandra .
    ```

### Run DBRS Cassandra as a standalone container

- PMEM memory in `devdax` or `fsdax`  mode, the container image is able to handle both modes and depending on the PMEM mode, the mount points inside the container should be different.

In order to make available `devdax` pmem devices inside the container you must use the `--device` directive, internally the container always uses `/dev/dax0.0`, so the mapping should be:

```
--device=/dev/<host-device>:/dev/dax0.0
```

In a similar fashion for `fsdax` we need the device to be mapped to `/mnt/pmem` inside the container:

```
--mount type=bind,source=<source-mount-point>,target=/mnt/pmem
```

#### Preparing PMEM for container use

In the current state, the cassandra-pmem image is capable of using both `fsdax` and `devdax`, the necessary steps to configure the PMEM to work with cassandra are documented here.

##### fsdax mode

First we need to verify that our PMEM is on `fsdax` mode

```
# ndctl list -u
{
  "dev":"namespace0.0",
  "mode":"fsdax",
  "map":"mem",
  "size":"4.00 GiB (4.29 GB)",
  "sector_size":512,
  "blockdev":"pmem0"
}
```

if for some reason the device is not on `fsdax` mode you can run `ndctl create-namespace -fe <namespace-name>  --mode=fsdax` to reconfigure the namespace to the desired mode.
Once the PMEM namespace is configured, a device named `/dev/pmem{0-9}` should appear then we need to proceed to create a filesystem on it. The filesystem could be `ext4` or `xfs`, for this example we are going to use `ext4`.

```
# mkfs.ext4 /dev/pmem0
mke2fs 1.45.2 (27-May-2019)
Creating filesystem with 1031680 4k blocks and 258048 inodes
Filesystem UUID: 303c03f5-ac4e-4462-8bf9-bc6b0fae53fe
Superblock backups stored on blocks:
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done
Writing inode tables: done
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done
```

Once the filesystem was created, we need to mount it with the dax option

```bash
mount /dev/pmem0 /mnt/pmem -o dax
```

When using `fsdax` mode cassandra-pmem creates a pool file on the pmem mountpoint, so the `jvm.options` configuration should look like the text below:

```
-Dpmem_path=/mnt/pmem/cassandra_pool
-Dpool_size=3221225472
```

Where

- pmem_path is the path to the pool file, which should include the path itself and the file name
- pool_size is the size of the pool file in bytes, if you are using the docker images provided here you can pass this value as an environment variable to the container runtime in Gb and the calculation is done automatically.

Is important to notice is that when creating the filesystem in the pmem device certain amount of space of the device is used by the filesystem metadata so the pool_size should be smaller than the total pmem namespace size.
When using the docker image provided here, the file `jvm.options` is automatically populated with the environment variables `CASSANDRA_PMEM_POOL_NAME` and `CASSANDRA_FSDAX_POOL_SIZE_GB`.

##### devdax mode

We need to verify if the device we want to use is in `devdax` mode

```
root@clear-pmem/home/development # ndctl create-namespace -fe namespace0.0  --mode=devdax
{
  "dev":"namespace0.0",
  "mode":"devdax",
  "map":"dev",
  "size":"3.94 GiB (4.23 GB)",
  "uuid":"cb738cc7-711d-4578-bebf-1f7ba02ca169",
  "daxregion":{
    "id":0,
    "size":"3.94 GiB (4.23 GB)",
    "align":2097152,
    "devices":[
      {
        "chardev":"dax0.0",
        "size":"3.94 GiB (4.23 GB)"
      }
    ]
  },
  "align":2097152
}
```

if not, we can reconfigure it using `ndctl create-namespace -fe <namespace-name>  --mode=devdax`. Before using a `devdax` device we need to clear the device:

```
root@clear-pmem/home/development # pmempool rm -vaf /dev/dax0.0
removed '/dev/dax0.0'
```

The `jvm.options` configuration for cassandra should look like the following:
```
-Dpmem_path=/dev/dax0.0
-Dpool_size=0
```

Where

- pmem_path is the `devdax` device.
- pool_size=0 indicates to use the entire `devdax` device.

When using the docker image provided here, the file `jvm.options` is automatically populated.

#### Start container

In `devdax` mode:

```bash
docker run --device=/<devdax-device>:/dev/dax0.0 --ulimit nofile=262144:262144 -p 9042:9042 -p 7000:7000 -it --name cassandra-test <image-id>
```

In `fsdax` mode:

```bash
docker run --mount type=bind,source=/<fsdax-mountpoint>,target=/mnt/pmem  --ulimit nofile=262144:262144 -p 9042:9042 -p 7000:7000 -it -e 'CASSANDRA_FSDAX_POOL_SIZE_GB=<fsdax-pool-size-in-gb>' --name cassandra-test <image-id>
```

#### Configure container

##### Using environment variables

By default the container listens on the primary container IP address, but if required, some parameters can be provided as environment variables using `--env`.

| **Environment Variable** | **Description** |
| --- | --- |
| `CASSANDRA_CLUSTER_NAME` | Cassandra cluster name, by default `Cassandra Cluster` |
| `CASSANDRA_LISTEN_ADDRESS` | Cassandra listen address |
| `CASSANDRA_RPC_ADDRESS` | Cassandra RPC address |
| `CASSANDRA_SEED_ADDRESSES` | A comma separated list of hosts in the cluster, if not provided, cassandra is going to run as a single node. |
| `CASSANDRA_SNITCH` | The snitch type for the cluster, by default it is `SimpleSnitch`, for more complex snitches you can mount your own `cassandra-rackdc.properties` file. |
| `LOCAL_JMX` | If set to `no` the JMX service will listen on all IP addresses, the default is `yes` and listens just on localhost 127.0.0.1 |
| `JVM_OPTS` | When set you can pass additional arguments to the JVM for cassandra execution, for example for specifying memory heap sizes `JVM_OPTS=-Xms16G -Xmx16G -Xmn12G` |

When using PMEM in `fsdax` mode, there are some parameters to control the allocation of memory:

| Environment Variable | Description |
| --- | --- |
| `CASSANDRA_FSDAX_POOL_SIZE_GB` | The size of the fsdax pool in GB, if it is not specified the pool size is `1` |
| `CASSANDRA_PMEM_POOL_NAME` | The filename of the pool created in PMEM, by default `cassandra_pool` |

##### Using custom files

For more complex deployments it is also possible to provide custom `cassandra.yaml` and `jvm.options` files as shown below:

```
docker run --mount type=bind,source=/<fsdax-mountpoint>,target=/mnt/pmem -it  --ulimit nofile=262144:262144 --mount type=bind,source=/<path-to-file>/cassandra.yaml,target=/workspace/cassandra/conf/cassandra.yaml --mount type=bind,source=/path-to-file>/jvm.options,target=/workspace/cassandra/conf/jvm.options --name cassandra-custom-files
```

#### Clustering

For a simple two node cluster using PMEM in `fsdax` mode on both containers:

##### Node 1

- IP: 172.17.0.2
- PMEM mountpoint: /mnt/pmem1

```
docker run --mount type=bind,source=/mnt/pmem1,target=/mnt/pmem  --ulimit nofile=262144:262144 -it -e 'CASSANDRA_FSDAX_POOL_SIZE_GB=2' -e 'CASSANDRA_SEED_ADDRESSES=172.17.0.2:7000,172.17.0.3:7000'  --name cassandra-node1 <image-id>
```

##### Node 2

- IP: 172.17.0.3
- PMEM mountpoint: /mnt/pmem2

```
docker run --mount type=bind,source=/mnt/pmem2,target=/mnt/pmem  --ulimit nofile=262144:262144 -it -e 'CASSANDRA_FSDAX_POOL_SIZE_GB=2' -e 'CASSANDRA_SEED_ADDRESSES=172.17.0.2:7000,172.17.0.3:7000'  --name cassandra-node2 <image-id>
```

Once both nodes are running eventually the gossip is settled and we can use `nodetool` on any of both containers to check cluster status.

```
docker exec -it <container-id> bash /workspace/cassandra/bin/nodetool status
```

The output should look similar to this:

```
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address     Load       Tokens       Owns (effective)  Host ID                               Rack
UN  172.17.0.3  0 bytes    256          100.0%            22387159-8192-41cf-8b6c-8bf0e1049eb7  rack1
UN  172.17.0.2  0 bytes    256          100.0%            219b56ba-c07c-400b-a018-a5dc20edeb09  rack1

```

#### Data persistence

By default the data written to cassandra can be accessed as long as the container exists. In order to persist the data a user can mount volumes or bind mounts on `/workspace/cassandra/data` and `/workspace/cassandra/logs`, in this way the data can still be accessed once the container is deleted.

### Deploy DBRS Cassandra cluster on Kubernetes

Many containerized workloads are deployed in clusters and orchestration software like Kubernetes, for this purpose the Helm chart located on `cassandra-pmem-helm` can be useful.

#### Kubernetes installation

To install Kubernetes in Clear Linux, follow the instructions in the Clear Linux's [Kubernetes Tutorial](https://docs.01.org/clearlinux/latest/tutorials/kubernetes.html)

After setting up Kubernetes, you will need to enable it to support DCPMM suing the pmem-csi driver. To install the driver follow the instructions in the [pmem-csi repository](https://github.com/intel/pmem-csi) file.

Then Kubernetes cluster must have [helm and tiller](https://helm.sh/) installed in order for the helm chart to deploy.

#### Helm chart configuration

In order to configure the cassandra pmem cluster some variables and values are provided. This values are set on `cassandra-pmem-helm/values.yaml`, those can also be modified according to your specific needs. A summary of those parameters is shown below:

| **Value** | **Description** |
| --- | --- |
| clusterName | The cluster Name set across all deployed nodes |
| replicaCount | The number of nodes in the cluster to be deployed |
| image.repository | The address of the container registry where the cassandra-pmem image should be pulled |
| image.tag | The tag of the image to be pulled during deployment |
| image.name | The name of the image to be pulled during deployment |
| pmem.containerPmemAllocation | The size of the persistent volume claim to be used as heap, it uses the storage class `pmem-csi-sc-ext4` from pmem-csi |
| pmem.fsdaxPoolSizeInGB | The size of the fsdax pool to be created inside the persistent volume claim, in practice it shuld be `1G` less than pmem.containerPmemAllocation |
| enablePersistence | If set to `true` K8s persistent volumes are deployed to store data and logs | 
| persistentVolumes.logsVolumeSize | The size of the persistent volume used for storing logs on each node, the default is `4G` |
| persistentVolumes.dataVolumeSize | The size of the persistent volume used for storing data on each node, the default is `4G` |
| persistentVolumes.logsStorageClass | K8s storage class used by  the logs pvc |
| persistentVolumes.dataStorageClass | K8s storage class used by  the data pvc |
| provideCustomConfig | If set to `true`, it mounts all the files located on `<helm-chart-dir>/files/conf` on `/workspace/cassandra/conf` inside each container in order to provide a way to customize the deployment beyond the options provided here |
| exposeJmxPort | When set to `true` it exposes the JMX port as part of the kubernetes headless service, it should be used together with `enableAdditionalFilesConfigMap` in order to provide authentication files needed for JMX when the remote connections are allowed, when set to `false` only local access through 127.0.0.1 is granted and no additional authentication is needed |
| enableClientToolsPod | If set to `true`, an additional pod independent from the cluster is deployed, this pod contains various Cassandra client tools and mounts test profiles located under `<helm-chart-dir>/files/testProfiles` to `/testProfiles` inside the pod. This pod is useful to test and launch benchmarks |
| enableAdditionalFilesConfigMap | When set to true, it takes the files located in `<helm-chart-dir>/files/additionalFiles` and mount them in `/etc/cassandra` inside the pods, some additional files for cassandra can be stored here, such as JMX auth files |
| jvmOpts.enabled | If set to `true` the environment variable `JVM_OPTS` is overriden with the value provided on jvmOpts.value |
| jvmOpts.value | Sets the value of the environment variable `JVM_OPTS`, in this way some java runtime configurations can be provided such as RAM heap usage |
| resources.enabled | if set to `true`, the resource constraints are set on each pod using the values under resources.requests and resources.limits |
| resources.requests.memory and resources.request.cpu | Initial resource allocation for each pod in the cluster |
| resources.limits.memory and resources.limits.cpu | Limits for cpu and memory for each pod in the cluster |

** **Important considerations when selecting volume sizes** **

When selecting the `fsdax` pool file size, it is important to consider that when requesting a volume, certain amount of space is used by the filesystem metadata on that volume, therefore the available space turns out to be less than total amount specified, taking this into consideration the size of the fsdax pool file should be ~2G less than the total volume size requested.

#### Helm chart deployment

Once all the configurations are set, to install the chart inside a given Kubernetes cluster you must run:

```bash
helm install ./cassandra-pmem-helm
```

Eventually all the given nodes will be shown as running using `kubectl get pods`.
