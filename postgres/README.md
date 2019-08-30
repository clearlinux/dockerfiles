PostgreSQL
==========
This provides a Clear Linux* PostgreSQL instance.

Build
-----
```
docker build -t clearlinux/postgres .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/postgres
```

Start PostgreSQL Container
-----------------------
```
docker run -p 5432:5432 -e POSTGRES_PASSWORD=secret -d clearlinux/postgres
```

Environment Variables
---------------------
- See ``Environment Variables`` section of the official postgres image [page](https://hub.docker.com/_/postgres).

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg

## Deploy with Kubernetes

This image can also be deployed on a Kubernetes cluster, such as [minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).The following example YAML files are provided in the repository as reference for Kubernetes deployment:

- [`postgres-deployment.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/postgres/postgres-deployment.yaml): example using default configuration with secret to create a basic postgres service.

- [`postgres-deployment-conf.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/postgres/postgres-deployment-conf.yaml): example using your own custom configuration with secret to create  postgres service.

  

If you want to deploy `postgres-deployment.yaml` on a Kubernetes cluster:

2. Create secret for postgres service.

   ```
   kubectl create secret generic postgres-config \
   --from-literal=POSTGRES_DB=<your-postgres-db> \
   --from-literal=POSTGRES_PASSWORD=<your-postgres-pwd> \
   --from-literal=POSTGRES_USER=<your-postgres-user>
   ```

3. Apply the YAML template configuraton.  

   ```
   kubectl create -f postgres-deployment.yaml
   ```

3. Install PostgreSQL bundle and connect to the service, where 30001 is the port number defined in your service.

   ```
   swupd bundle-add postgresql
   psql -h<nodeIP> -U<your-postgres-user> --password -p30001 <your-postgres-db>
   ```

   

If you want to deploy `postgres-deployment-conf.yaml` on a Kubernetes cluster:

1. Create secret for postgres service.

   ```
   kubectl create secret generic postgres-config \
   --from-literal=POSTGRES_DB=<your-postgres-db> \
   --from-literal=POSTGRES_PASSWORD=<your-postgres-pwd> \
   --from-literal=POSTGRES_USER=<your-postgres-user>
   ```

2. Apply the YAML template configuraton.  

   ```
   kubectl create -f postgres-deployment-conf.yaml
   ```

3. Install PostgreSQL bundle and connect to the service, where 30001 is the port number defined in your service.

   ```
   swupd bundle-add postgresql
   psql -h<nodeIP> -U<your-postgres-user> --password -p30001 <your-postgres-db>
   ```

   

