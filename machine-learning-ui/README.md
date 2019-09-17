Machine Learning
================
[![](https://images.microbadger.com/badges/image/clearlinux/machine-learning-ui.svg)](http://microbadger.com/images/clearlinux/machine-learning-ui "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/clearlinux/machine-learning-ui.svg)](http://microbadger.com/images/clearlinux/machine-learning-ui "Get your own version badge on microbadger.com")

This provides a machine learning environment with the `machine-learning-web-ui`,
bundle from [Clearlinux](https://clearlinux.org/documentation/bundles_overview.html)

Build
-----
```
docker build -t clearlinux/machine-learning-ui .
```

Or just pull it from Dockerhub
------------------------------
```
docker pull clearlinux/machine-learning-ui
```

Run the machine-learning-ui Container
----------------------------------
```
docker run -p 8888:8888 -it clearlinux/machine-learning-ui
```

Environment Variables
---------------------
none

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg

### Deploy with Kubernetes

This image can also be deployed on a Kubernetes cluster, such as [minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).The following example YAML files are provided in the repository as reference for Kubernetes deployment:

- [`machine-learning-ui-deployment.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/machine-learning-ui/machine-learning-ui-deployment.yaml): example to provide jupyter notebook service.

  

Steps to deploy notebook on a Kubernetes cluster:

1. Deploy `machine-learning-ui-deployment.yaml`

   ```
   kubectl create -f machine-learning-ui-deployment.yaml
   ```

2. Navigate to [http://\<nodeIP\>:30001](http://\<nodeIP\>:30001) in your browser, where 30001 is the port number defined in your service.