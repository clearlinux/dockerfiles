# Clear Linux Based Container: Nginx Service

This container provides a nginx web service, which is same as [the one](https://hub.docker.com/_/nginx) from dockerhub in functionality with optimized libraries and secure content from Clear Linux*. It can be executed by docker tool directly or deployed on any docker orchrestration like kubernetes.

## Build Container
```
docker build -t clearlinux/nginx .
```
Or just pull it from Dockerhub

```
docker pull clearlinux/nginx
```
Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg, extra Build ARGs:

- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

## Run with Docker Tool
Quick start container:
```
docker run -p 80:80 -v /some/content:/var/www/html -d clearlinux/nginx
```
_Note: The default root path is **/var/www/html** and default configuration path is **/etc/nginx/**._

_See ``How to use this image`` section of the official nginx image [page](https://hub.docker.com/_/nginx)_.

## Deploy on Kubernetes Cluster
This container could be deployed on any kubernetes compatible cloud native cluster such as minikube or CSP's platform. Please refer [here](https://kubernetes.io/docs/setup/learning-environment/minikube/) to setup minikube.

Following template files as kubernete YAML registries for operator's reference:

* nginx-service-deployment-simple.yaml: use default configurations to create nginx service on kubernetes cluster
* nginx-service-deployment-customize-conf.yaml: demostrate how to use customized config file to replace default one.
* nginx-service-deployment-persistent-volume.yaml: demostrate how to manage web server materials on persistent storage.

Quick deployment for test:
```
kubectl apply -f nginx-service-deployment-<xxx>.yaml
```
On minikube cluster, to visit demo web service:
```
minikube service clear-nginx-service
```