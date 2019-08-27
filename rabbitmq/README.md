# Clear Linux* OS `rabbitmq` container image

<!-- Required -->
## What is this image?

`clearlinux/rabbitmq` is a Docker image with `rabbitmq` running on top of the
[official clearlinux base image](https://hub.docker.com/_/clearlinux).

<!-- application introduction -->
> [rabbitmq](https://en.wikipedia.org/wiki/RabbitMQ) is an open-source message-broker software
> originally implemented the Advanced Message Queuing Protocol (AMQP) and has since been extended with a plug-in architecture 
> to support Streaming Text Oriented Messaging Protocol (STOMP), Message Queuing Telemetry Transport (MQTT), and other protocols.

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

*Note: This container is compatible with the [official wordpress
image](https://hub.docker.com/_/rabbitmq). 

1. Pull the image from Docker Hub:
    ```
    docker pull clearlinux/rabbitmq
    ```

2. Start a rabbitmq-server instance:
    ```
    docker run --rm -it --hostname my-rabbit --name some-rabbit clearlinux/rabbitmq
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
    cd rabbitmq/
    ```

3. Build the container image:
    ```
    docker build -t clearlinux/rabbitmq .
    ```

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
