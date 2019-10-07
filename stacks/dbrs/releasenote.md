
# Database Reference Stack

The Database Reference Stack, an integrated, highly-performant open source stack optimized for next-generation 2nd Generation Intel® Xeon® Scalable processors with Intel® Optane™ DC persistent memory. This open source community release is part of our effort to ensure datacenters can reduce the bottlenecks and data latency by implementing intelligent, scalable and cost-effective storage mechanisms. The Database Reference Stack boosts the performance of data-intensive applications using traditional SSD storage drives by using DIMM modules as a persistant system storage.

> **Note:**
     For more information regarding Intel® Optane™ DC persistent memory please visit the [official Optane web page](https://www.intel.com/content/www/us/en/architecture-and-technology/intel-optane-technology.html).


# The Database Reference Stack Releases

To offer more flexibility, we are releasing multiple versions of the Database Reference Stack. All versions are built on top of the Clear Linux OS, which is optimized for I/O.

> **Note:**
     Clear Linux will be automatically updated to the latest release version in the container. The minimum validated version of Clear Linux for this stack is 30770.


## The Database Reference Stack with Cassandra

The release includes:
  * Clear Linux* OS
  * Cassandra 4.0 with persistent memory feature in App-Direct mode.
  * PMDK 1.5.1 library as the storage engine
  * openjdk 1.8.0

> **Note:**
     The PMDK library support has been added to the kernel since version 4.9, however it has more estability on kernel versions 5.0+


## The Database Reference Stack with Redis

The release includes:
  * Clear Linux* OS
  * Redis 4.0 with persistent memory feature in App-Direct mode.
  * memkind 1.9.0 library as the storage engine

## How to get the Database Reference Stack

The official Database Reference Stack Docker images are hosted at: https://hub.docker.com/u/clearlinux/:

 * Pull from the [Cassandra image](https://hub.docker.com/r/clearlinux/stacks-dbrs-cassandra)
 * Pull from the [Redis image](https://hub.docker.com/r/clearlinux/stacks-dbrs-redis)


# Licensing

The Database Reference Stack is guided by the same [Terms of Use](https://download.clearlinux.org/TermsOfUse.html) declared by the Clear Linux project. The Docker images are hosted on https://hub.docker.com and as with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc. from the base distribution, along with any direct or indirect dependencies of the primary software being contained).


# Working with the Database Reference Stack

The components of the Database Reference stack where selected because they support use of DCPMM in App-Direct Mode.

The images can be used in a Kubernetes cluster as a multi-node environment. To enable DCPMM support in Kubernetes, it is required to use the [pmem-csi driver](https://github.com/intel/pmem-csi) to create the storage classes which will map to the DCPMM regions in fsdax mode.

Please refer to the [Database Reference Stack tutorial](https://docs.01.org/clearlinux/latest/guides/stacks/dbrs.html) for detailed instructions for running the benchmarks on the docker images.


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
