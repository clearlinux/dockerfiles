memcached
==========
This provides a Clear Linux* memcached instance.

Build
-----
```
docker build -t clearlinux/memcached .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/memcached
```

Start a memcached server 
-----------------------
```
docker run --network somenetwork --name memcached-server -d clearlinux/memcached
```

Benchmark test using memtier benchmark
---------------------
Please refer to the [page](https://github.com/RedisLabs/memtier_benchmark) for details.

```
docker pull redislabs/memtier_benchmark
docker run --rm --network somenetwork redislabs/memtier_benchmark ./memtier_benchmark --server=memcached-server -p 11211 -P memcache_text
```

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg

## Run memcached on  kubernetes cluster

```
kubectl create -f memcached-deployment.yaml
```

## Deploy with Kubernetes

This image can also be deployed on a Kubernetes cluster, such as [minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).The following example YAML files are provided in the repository as reference for Kubernetes deployment:

- [`memcached-deployment.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/memcached/memcached-deployment.yaml): example using default configuration to create a basic memcached service.

To deploy the image on a Kubernetes cluster:

1. Review the contents of the template file and edit appropriately for your needs.

2. Apply the YAML template configuraton.

   ```
   kubectl create -f memcached-deployment.yaml
   ```


3. Install telnet bundle and connect to the service, where 30100 is the port number defined in your service.

   ```
   swupd bundle-add netkit-telnet
   telnet <nodeIP> 30100
   ```

   