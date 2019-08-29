Redis
==========
This provides a Clear Linux* Redis instance.

Build
-----
```
docker build -t clearlinux/redis .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/redis
```

start a redis instance
-----------------------
```
docker run --name some-redis --network some-network -d clearlinux/redis redis-server --protected-mode no
```

connecting via redis-cli
---------------------
```
docker run -it --network some-network --rm clearlinux/redis redis-cli -h some-redis
```

benchmark test
---------------------
```
docker run --network some-network --rm clearlinux/redis redis-benchmark -h some-redis
```

details of how-to
---------------------
Please refer to the official redis image [page](https://hub.docker.com/_/redis).

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg



## Deploy with Kubernetes

This image can also be deployed on a Kubernetes cluster, such as [minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).The following example YAML files are provided in the repository as reference for Kubernetes deployment:

- [`redis-deployment.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/redis/redis-deployment.yaml): example using default configuration to create a basic redis service.
- [`redis-deployment-conf.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/redis/redis-deployment-conf.yaml): example using your own custom configuration to create a redis service.



If you want to deploy `redis-deployment.yaml` on a Kubernetes cluster:

1. Apply the YAML template configuraton.

   ```
   kubectl create -f redis-deployment.yaml
   ```

2. Install redis bundle and connect to the service, where 30001 is the port number defined in your service.

   ```
   swupd bundle-add redis-native
   redis-cli -h <nodeIP> -p 30001
   ```



If you want to deploy `redis-deployment-conf.yaml` on a Kubernetes cluster:

1. Apply the YAML template configuration, here custom configuration is mounted in path: /etc/redis.conf

   ```
   kubectl create -f redis-deployment-conf.yaml
   ```

2. Install redis bundle and connect to the service, where 30001 is the port number defined in your service.

   ```
   swupd bundle-add redis-native
   redis-cli -h <nodeIP> -p 30001
   ```

   