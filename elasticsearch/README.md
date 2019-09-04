# Clear Linux* OS `elasticsearch` container image

<!-- Required -->
## What is this image?

`clearlinux/elasticsearch` is a Docker image with `elasticsearch` running on top of the
[official clearlinux base image](https://hub.docker.com/_/clearlinux). 

<!-- application introduction -->
> [Elasticsearch](https://www.elastic.co/) is a search engine based on the Lucene library 
> It provides a distributed, multitenant-capable full-text search engine with an HTTP web 
> interface and schema-free JSON documents. Elasticsearch is developed in Java.

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

*Note: This container uses the same syntax as the [official elasticsearch image](https://hub.docker.com/_/elasticsearch).


1. Pull the image from Docker Hub: 
    ```
    docker pull clearlinux/elasticsearch
    ```

2. Start a container using the examples below:
    ```
    docker volume create esdata
    docker run -d -p 9200:9200 -e "discovery.type=single-elasticsearch" -v esdata:/var/data/elasticsearch clearlinux/elasticsearch
    ```
    
3. Check cluster health
    ```
    curl http://localhost:9200/_cluster/health?pretty
    ```
    
4. Create an index called customer
    ```
    curl -X PUT "localhost:9200/customer?pretty"
    ```
    
5. Add new document to that index
    ```
    curl -X PUT "localhost:9200/customer/doc/1?pretty" -H 'Content-Type: application/json' -d'{"name": "Tom John" }'
    curl -X PUT "localhost:9200/customer/doc/2?pretty" -H 'Content-Type: application/json' -d'{"name": "Kelly Wong" }'
    ```
    
6. View documents in the index
    ```
    curl localhost:9200/customer/_search?pretty
    ```

<!-- Optional -->
### Deploy with Kubernetes

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
    cd elasticsearch/
    ```

3. Build the container image:
    ```
    docker build -t clearlinux/elasticsearch .
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
