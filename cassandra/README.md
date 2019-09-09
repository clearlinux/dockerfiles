# Clear Linux* OS `cassandra` container image

<!-- Required -->
## What is this image?

`clearlinux/cassandra` is a Docker image with `cassandra` running on top of the
[official clearlinux base image](https://hub.docker.com/_/clearlinux). 

<!-- application introduction -->
> [Cassandra](http://cassandra.apache.org/) is a free and open-source, distributed, 
> wide column store, NoSQL database management system designed to handle large amounts 
> of data across many commodity servers, providing high availability with no single 
> point of failure. Cassandra offers robust support for clusters spanning multiple 
> datacenters, with asynchronous masterless replication allowing low latency operations 
> for all clients.  

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

*Note: This container uses the same syntax as the [official cassandra image](https://hub.docker.com/_/cassandra).


1. Pull the image from Docker Hub: 
    ```
    docker pull clearlinux/cassandra
    ```

2. Start a container using the examples below:

    ```
    docker run --name some-cassandra --network some-network -d clearlinux/cassandra:tag
    ```
    
    connect to cassandra from cqlsh
    ---------------------
    ```
    docker run -it --network some-network --rm clearlinux/cassandra cqlsh -h some-cassandra
    ```

<!-- Optional -->
### Deploy with Kubernetes
This image can also be deployed on a Kubernetes cluster.The following example YAML files are provided 
in the repository as reference for deploying Cassandra with Stateful Sets on a single node cluster:

- [`pv-local.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/cassandra/pv-local.yaml): local persistent volumes for cassandra database.
- [`storageclass.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/cassandra/storageclass.yaml): create a StorageClass with the volumeBindingMode set to “WaitForFirstConsumer”
- [`cassandra-deployment.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/cassandra/cassandra-deployment.yaml): example using default configuration to create a basic cassandra service.
- [`cassandra-deployment-conf.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/cassandra/cassandra-deployment-conf.yaml): example using your own custom configuration to create a cassandra service.
- [`cassandra-statefulset.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/cassandra/cassandra-statefulset.yaml): create a Headless Service and a Statefulset for Cassandra with three replicas.



**In this tutorial, we proposed 2 different kinds of method to deploy cassandra: stateless and stateful**

If you want to deploy Cassandra in **stateful** manner, the example uses official clearlinux cassandra container, to deploy this container on a Kubernetes cluster, please follow with below steps:

1. Create /mnt/disks directory on local test cluster

   ```
   $ mkdir /mnt/disks
   $ for vol in vol1 vol2 vol3; do
         mkdir /mnt/disks/$vol
         chmod 777 /mnt/disks/$vol
   done
   ```

2. Create a StorageClass

   ```
   kubectl apply -f storageclass.yaml
   ```

3. Create local persistent volumes

   ```
   kubectl apply -f pv-local.yaml
   ```

4. Create a Headless Service and a Statefulset for Cassandra with three replicas

   ```
   kubectl apply -f cassandra-statefulset.yaml 
   ```

5. Validate the Cassandra StatefulSet

   *Get the Cassandra StatefulSet:

   ```
   kubectl get statefulset cassandra
   ```

   ```
   The response should be:
   
   NAME        READY   AGE
   cassandra   4/4     19h
   ```

   *Get the Pods to see the ordered creation status:

   ```
   kubectl get pods -l="app=cassandra"
   ```

   ```
   The response should be:
   
   NAME          READY   STATUS    RESTARTS   AGE
   cassandra-0   1/1     Running   0          19h
   cassandra-1   1/1     Running   0          19h
   cassandra-2   1/1     Running   1          19h
   cassandra-3   1/1     Running   1          19h
   ```

   *Run the Cassandra nodetool to display the status of the ring

   ```
   kubectl exec -it cassandra-0 -- nodetool status
   ```

   ```
   The response should be:
   
   Datacenter: datacenter1
   =======================
   Status=Up/Down
   |/ State=Normal/Leaving/Joining/Moving
   --  Address      Load       Tokens   Owns (effective)  Host ID  Rack
   UN  10.244.0.64  227.89 KiB  256     24.4%      d0bf15be-ce18-40be-b3c2-f6f80e307e31  rack1
   UN  10.244.0.61  189.28 KiB  256     23.2%      2aa68c9c-99b7-4a70-803a-5886019391ac  rack1
   UN  10.244.0.62  195.16 KiB  256     28.1%      ecb0fe92-2b28-4be5-921d-a7d6b3367b5f  rack1
   UN  10.244.0.63  228.66 KiB  256     24.3%      9720efad-a434-4b81-9434-9b7cafd72a9b  rack1
   ```



If you want to deploy Cassandra in **stateless** manner, please follow with below steps:

1. If you want to deploy `cassandra-deployment.yaml`

   ```
   kubectl create -f cassandra-deployment.yaml
   ```

   Or if you want to deploy `cassandra-deployment-conf.yaml`  

   ```
   kubectl create -f cassandra-deployment-conf.yaml
   ```

2. Install Cassandra bundle and add environmental variable.

   ```
   source cassandra-setup.sh
   ```

3. Connect to the service, where 30001 is the port number defined in your service.

   ```
   cqlsh <nodeIP> 30001
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
    cd cassandra/
    ```

3. Build the container image:
    ```
    docker build -t clearlinux/cassandra .
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
