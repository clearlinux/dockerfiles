# Clear Linux* OS `tensorflow-serving` container image

<!-- Required -->
## What is this image?

`clearlinux/tensorflow-serving` is a Docker image with `tensorflow-serving` running on top of the
[official clearlinux base image](https://hub.docker.com/_/clearlinux). 

<!-- application introduction -->
> [Tensorflow-serving](https://github.com/tensorflow/serving) is a flexible,
> high-performance serving system for machine learning models.

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

*Note: This container uses the same syntax as the [official tensorflow-serving image](https://hub.docker.com/r/tensorflow/serving).


1. Pull the image from Docker Hub: 
    ```
    docker pull clearlinux/tensorflow-serving
    ```

2. Download a tensorflow-serving repo and setup the location of demo models
    ```
    git clone https://github.com/tensorflow/serving
    TESTDATA="$(pwd)/serving/tensorflow_serving/servables/tensorflow/testdata"
    ```
    
3. Start a container using the examples below:

    ```
    docker run -t --rm -p 8501:8501 \
    -v "$TESTDATA/saved_model_half_plus_two_cpu:/models/half_plus_two" \
    -e MODEL_NAME=half_plus_two \
    clearlinux/tensorflow-serving &
    ```
    
4. Query the model using the predict API and the return => { "predictions": [2.5, 3.0, 4.5] }

    ```
    curl -d '{"instances": [1.0, 2.0, 5.0]}' \
    -X POST http://localhost:8501/v1/models/half_plus_two:predict
    ```

### Deploy with Kubernetes

This image can also be deployed on a Kubernetes cluster, such as [minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).The following example YAML files are provided in the repository as reference for Kubernetes deployment:

- [`tensorflow-serving-deployment.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/tensorflow-serving/tensorflow-serving-deployment.yaml): example to create a basic tensorflow-serving service.



Steps to deploy tensorflow-serving on a Kubernetes cluster:

1. Download a tensorflow-serving repo.

   ```
   cd /var/tmp
   git clone https://github.com/tensorflow/serving
   ```

2. Deploy `tensorflow-serving-deployment.yaml` .

   ```
   kubectl create -f tensorflow-serving-deployment.yaml
   ```

3. Query the model using the predict API and the return => { "predictions": [2.5, 3.0, 4.5] }, where 30001 is the port number defined in your service.

   ```
   curl -d '{"instances": [1.0, 2.0, 5.0]}' \
   -X POST http://<nodeIP>:30001/v1/models/half_plus_two:predict
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
    cd tensorflow-serving/
    ```

3. Build the container image:
    ```
    docker build -t clearlinux/tensorflow-serving .
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
