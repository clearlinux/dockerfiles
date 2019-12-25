Contributing Guidelines
=======================

Developing Derivative Images
----------------------------

When using Clear Linux as a base for deriving an existing image from Docker
Hub, the goal should be to maintain the same usage of the existing image for
the derivative. This maintains compatibility for users because they will be
able to operate with the derivative in the same manner as the existing image.
This often means:

* Naming the derivative image exactly the same as the existing image.
  Documentation references of the name in the derivative README should be
  exactly the same as the existing README.
* Modeling the derivative Dockerfile from the existing Dockerfile, removing
  pieces that are not relevant for Clear Linux, and supplying defaults required
  to operate the microservice on Clear Linux
* Reusing entry point shell scripts from the existing image
* Having a section in the README of the derivative image that references the
  README of the existing image
* Having a section in the README of the derivative image that includes an Extra
  Build args section mentioning how to use swupd

Common existing Dockerfiles may be found at the
[repository](https://github.com/docker-library/official-images/) for Docker
library's official images.

Criteria for Pull Request Acceptance
------------------------------------

A pull request will be accepted for an image if it satisfies the guidelines
mentioned above.

When opening a pull request, be sure to also modify the .github/workflows/
tests.yml to add new item in matrix.node:

```
   matrix:
     node: ["name of folder containing image"]
```

Make sure this entry is in sorted order in the existing list of items in the
matirx.node.

This step allows the build of the image to be tested in Actions CI.

Because of the current usage of Actions CI, any pull request change will trigger
a rebuild of all images. Some of these may fail. The only failure that is
blocking is if the image in question does not build in Actions CI.
