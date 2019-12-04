# Clear Linux* OS `tesseract-ocr` container image

<!-- Required -->
## What is this image?

`clearlinux/tesseract-ocr` is a Docker image with OCR engine `libtesseract` and cmdline tool `tesseract`
 on top of the [official clearlinux base image](https://hub.docker.com/_/clearlinux). 

<!-- application introduction -->
> [tesseract](https://github.com/tesseract-ocr/tesseract) is an open source
> optical character recognition (OCR) platform. OCR extracts text from images and
> documents without a text layer and outputs the document into a new searchable text file,
> PDF, or most other popular formats. 

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

1. Pull the image from Docker Hub: 
    ```
    docker pull clearlinux/tesseract-ocr
    ```

2. Start a container using the examples below
    ```
    docker run --rm -it --name myapp -v "$PWD":/app -w /app clearlinux/tesseract-ocr tesseract xxx.tiff stdout --oem 1
    ```
    or if trained data for language is in $PWD,
    ```
    docker run --rm -it --name myapp -e "TESSDATA_PREFIX=/app" -v "$PWD":/app -w /app clearlinux/tesseract-ocr tesseract xxx.tiff stdout --oem 1
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
    cd tesseract-ocr/
    ```

3. Build the container image:
    ```
    docker build -t clearlinux/tesseract-ocr .
    ```

4. Please refer to [create custom application container image](https://docs.01.org/clearlinux/latest/guides/maintenance/container-image-modify.html) on how to customize your container image with specific debug capabilities, such as: make, git.

   Refer to the Docker documentation for [default build arguments](https://docs.docker.com/engine/reference/builder/#arg).
   Additionally:
   
   - `swupd_args` - specifies arguments to pass to the Clear Linux* OS software
     manager. See the [swupd man pages](https://github.com/clearlinux/swupd-client/blob/master/docs/swupd.1.rst#options)
     for more information.

## note:
  > The container doesn't include any trained data for language. You need download specific language file from
  > https://github.com/tesseract-ocr/tessdata and copy to /usr/share/tessdata, e.g to support English, you need copy eng.traineddata.
<!-- Required -->
## Licenses

All licenses for the Clear Linux* Project and distributed software can be found
at https://clearlinux.org/terms-and-policies
