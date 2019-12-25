# Clear Linux* OS `openvino` container image

<!-- Required -->
## What is this image?

`clearlinux/openvino` is a Docker image with `dldt` running on top of the
[official clearlinux base image](https://hub.docker.com/_/clearlinux).

<!-- application introduction -->
> [openvino](https://01.org/openvinotoolkit) OpenVINO™ toolkit, short
> for Open Visual Inference and Neural network Optimization toolkit, provides
> developers with improved neural network performance on a variety of
> Intel® processors and helps them further unlock cost-effective, real-time
> vision applications.

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


## Environment variables

#### MODEL_DIR
It is the root directory to save openvino models, default /models.

#### MO_PATH
It points to the path of Model Optimizer mo.py.
It is "/usr/share/openvino/model-optimizer/mo.py" in default.

#### MODEL_NAME
The model name to be used. 
If it is not pre-downloaded, the entrypoint script will do the downloading and
converting to IR format.
Run the below command can get all supported models.
```
docker run --rm clearlinux/openvino model-downloader --print_all
```

#### MODEL_PRECISION
The model precision to be chosen, FP32, FP16 or INT8.

#### MODEL_PATH
The chosen model path, automatically set by the entrypoint script.

For example, if using [`mobilenetv2-int8-tf-0001`](https://github.com/opencv/open_model_zoo/blob/master/models/intel/mobilenetv2-int8-tf-0001/description/mobilenetv2-int8-tf-0001.md) model to do classification, two environment variables need to be passed to the container.
Details can refer to the deployment below.

Note, use trained and quantized INT8 fixed-point precision model such as `mobilenetv2-int8-tf-0001`
on AVX512 VNNI platform could get [big performance advantage](https://www.intel.ai/vnni-enables-inference/).

<!-- Required -->
## Deployment:

### Deploy with Docker
The easiest way to get started with this image is by simply pulling it from
Docker Hub.

1. Pull the image from Docker Hub:
    ```
    docker pull clearlinux/openvino
    ```

2. Start one-time classification_sample with mobilenetv2-int8-tf-0001 model as below:

   * Use docker-compose to start the example:
     ```
     docker-compose -f docker-compose.yml up
     ```
     The configuration is defined in the
     [`docker-compose.yml`](https://github.com/clearlinux/dockerfiles/blob/master/openvino/docker-compose.yml)


Or

3. Start a simple openvino-server to accept image to do classification_sample with mobilenetv2-int8-tf-0001 model:

   * Use docker-compose to start the server first:
     ```
     docker-compose -f docker-compose-server.yml up
     ```
     The configuration is defined in the
     [`docker-compose-server.yml`](https://github.com/clearlinux/dockerfiles/blob/master/openvino/docker-compose-server.yml)

   * Use curl to send image to the server for classification:
     ```
     curl -H "Content-type: application/octet-stream" -X POST http://localhost:5000/image --data-binary @cat.bmp
     ```


<!-- Optional -->
### Deploy with Kubernetes
This image can also be deployed on a Kubernetes cluster, such as
[minikube](https://kubernetes.io/docs/setup/learning-environment/minikube/).The
following example YAML files are provided in the repository as
reference for Kubernetes deployment:

   * [`classification.yaml`](https://github.com/clearlinux/dockerfiles/blob/master/openvino/classification.yaml):
     yaml file to deploy the openvino classification example

To deploy the image on a Kubernetes cluster:

   * Start the openvino classification example server.
     ```
     kubectl apply -f classification.yaml
     ```

   * Then check if the pods are running well.
     ```
     kubectl get pods -o wide
     ```
     This may take some time because it requires downloading/converting the model.
     Note, if your cluster is behind some proxy, you may need set the proxy
     environment in the yaml file to make the model-init can download the model.

   * Get server PORT and IP
     ```
     PORT=`kubectl get -o jsonpath="{.spec.ports[0].nodePort}" services openvino-server`
     NODEIP=`kubectl get nodes -o jsonpath="{.items[0].status.addresses[0].address}"`
     ```

   * Use curl to send image to the server for classification:
     ```
     curl -H "Content-type: application/octet-stream" -X POST http://$NODEIP:$PORT/image --data-binary @cat.bmp
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
    cd openvino/
    ```

3. Build the container image:
    ```
    docker build -t clearlinux/openvino .
    ```
   
   [`models.txt`](https://github.com/clearlinux/dockerfiles/blob/master/openvino/models.txt):
   It defines the models will be pre-downloaded and converted to IR format in container image.

   [`requirements.txt`](https://github.com/clearlinux/dockerfiles/blob/master/openvino/requirements.txt):
   It defines the python packages to be installed in container image.

   Refer to the Docker documentation for [default build
   arguments](https://docs.docker.com/engine/reference/builder/#arg).
   Additionally:
   
   - `swupd_args` - specifies arguments to pass to the Clear Linux* OS software
     manager. See the [swupd man
     pages](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options)
     for more information.

<!-- Required -->
## Licenses

All licenses for the Clear Linux* Project and distributed software can be found
at https://clearlinux.org/terms-and-policies
