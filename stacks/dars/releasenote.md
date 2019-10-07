
# Data Analytics Reference Stack

The Data Analytics Reference Stack, is an integrated, highly-performant stack optimized for Intel® Xeon® Scalable platforms. This open source community release is part of an effort to ensure enterprises have easy access to all features and functionality of Intel platforms.

Highly-tuned and built for enterprises, the release enables application developers and architects a powerful way to store and process large amounts of data using a distributed processing framework to efficiently build big-data solutions and solve domain-specific problems. Having a streamlined system stack frees users from the complexity of integrating multiple components and software versions, and delivers a stable, performant platform upon which to quickly develop, test, and deploy solutions.

The stack includes tuned software components across the operating system (Clear Linux OS),  Runtimes (Open Java Development Kit* (OpenJDK)), Math Libraries (Intel ® Math Kernel Library (MKL), open source Basic Linear Algebra Subprograms (OpenBLAS)), frameworks (Apache Hadoop*, Apache Spark*), and other software components.

> **Note:**
Clear Linux will be automatically updated to the latest release version in the container. The minimum validated version of Clear Linux for this stack is 30970.

## Stack Features

The Data Analytics Reference Stack provides two pre-built Docker images, available on Docker Hub:

A Clear Linux OS-derived [DARS with OpenBlas](https://hub.docker.com/r/clearlinux/stacks-dars-openblas) stack optimized for [OpenBLAS](http://www.openblas.net)
A Clear Linux OS-derived [DARS with Intel® MKL](https://hub.docker.com/r/clearlinux/stacks-dars-mkl) stack optimized for [MKL](https://software.intel.com/en-us/mkl) (Intel® Math Kernel Library)

## The Data Analytics Reference Stack with MKL

The release includes:
  * Clear Linux* OS
  * Apache Spark 2.4.0
  * Apache Hadoop 3.2.0
  * OpenJDK 11.0.4
  * Intel® Math Kernel Library 2019 [Update 5](https://software.intel.com/en-us/articles/intel-math-kernel-library-release-notes-and-new-features)

## The Data Analytics Reference Stack with OpenBLAS

The release includes:
  * Clear Linux* OS
  * Apache Spark 2.4.0
  * Apache Hadoop 3.2.0
  * OpenJDK 11.0.4
  * OpenBLAS 0.3.6

# Licensing

The Data Analytics Reference Stack is guided by the same [Terms of Use](https://download.clearlinux.org/TermsOfUse.html) declared by the Clear Linux project. The Docker images are hosted on https://hub.docker.com and as with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc. from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

# Working with the Data Analytics Reference Stack

The images can be used in a Kubernetes cluster as a multi-node environment. Please see the [Data Analytics Reference Stack documentation](https://docs.01.org/clearlinux/latest/guides/stacks/dars.html) to get detailed instructions.
Please refer to the [Data Analytics Reference Stack tutorial](https://clearlinux.org/documentation/clear-linux/tutorials/dars) for detailed instructions for running the benchmarks on the docker images.

# Contributing to the Database Reference Stack

We encourage your contributions to this project, through the established Clear Linux community tools.  Our team uses typical open source collaboration tools that are described on the Clear Linux [community page](https://clearlinux.org/community).

# Reporting Security Issues

  If you have discovered potential security vulnerability in an Intel product, please contact the iPSIRT at secure@intel.com.

  It is important to include the following details:

  * The products and versions affected
  * Detailed description of the vulnerability
  * Information on known exploits

  Vulnerability information is extremely sensitive. The iPSIRT strongly recommends that all security vulnerability reports sent to Intel be encrypted using the iPSIRT PGP key. The PGP key is available here: https://www.intel.com/content/www/us/en/security-center/pgp-public-key.html

  Software to encrypt messages may be obtained from:

  * PGP Corporation
  * GnuPG
