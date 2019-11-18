# Clear Linux* OS `mariadb` Helm Charts

<!-- Required -->
## What is this image?

`clearlinux/mariadb` is a Docker image with `mariadb` running on top of the
[official clearlinux base image](https://hub.docker.com/_/clearlinux). 

<!-- application introduction -->

> [Mariadb](https://mariadb.com/) is a community-developed, commercially supported 
> fork of the MySQL relational database management system (RDBMS), intended to remain 
> free and open-source software under the GNU General Public License. Development is led 
> by some of the original developers of MySQL, who forked it due to concerns over its 
> acquisition by Oracle Corporation

For other Clear Linux* OS
based container images, see: https://hub.docker.com/u/clearlinux

## Why use a clearlinux based image?

<!-- CL introduction -->

> [Clear Linux* OS](https://clearlinux.org/) is an open source, rolling release
> Linux distribution optimized for performance and security, from the Cloud to
> the Edge, designed for customization, and manageability.

Clear Linux* OS based container images use:

- Optimized libraries that are compiled with latest compiler versions and
  flags.
- Software packages that follow upstream source closely and update frequently.
- An aggressive security model and best practices for CVE patching.
- A multi-staged build approach to keep a reduced container image size.
- The same container syntax as the official images to make getting started
  easy. 

To learn more about Clear Linux* OS, visit: https://clearlinux.org.

<!-- Required -->

## Prerequisites

- PV provisioner support in the underlying infrastructure

## Installing the Mariadb Chart

Download the mariadb chart and install the chart with the release name ` my-release` 

```
$ helm install --name my-release mariadb
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

The following table lists the configurable parameters of the MariaDB chart and their default values.

| Parameter                | Description                                    | Default                        |
| ------------------------ | ---------------------------------------------- | ------------------------------ |
| `image.replicaCount`     | Mariadb pod count                              | `2`                            |
| `image.repository`       | MariaDB image repository                       | `docker.io/clearlinux/mariadb` |
| `image.imagepullPolicy`  | MariaDB image pull policy                      | `IfNotPresent`                 |
| `service.type`           | MariaDB service type                           | `NodePort`                     |
| `service.port`           | MariaDB service port                           | `3306`                         |
| `service.targetPort`     | MariaDB service targetPort                     | `3306`                         |
| `service.nodePort`       | MariaDB service nodePort                       | `30001`                        |
| `config.enabled`         | If apply custom config file to Mariadb service | `True`                         |
| `config.content`         | custom file content                            | `your own custom conf`         |
| `config.name`            | config volume name                             | `config-volume`                |
| `mariadbRootPassword`    | Mariadb Root Password                          | `nil`                          |
| `mariadbUser`            | Mariadb User Name                              | `nil`                          |
| `mariadbPassword`        | Mariadb User Password                          | `nil`                          |
| `persistence.enabled`    | if pv is enabled to Mariadb service            | `True`                         |
| `persistence.accessMode` | pv accessMode for Mariadb service              | `ReadWriteMany`                |
| `persistence.size`       | pv size for Mariadb service                    | `1Gi`                          |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```
$ helm install --name my-release \
  --set mariadbRootPassword=<your-root-password>,mariadbUser=<your-user-name>,mariadbPassword=<your-user-password> mariadb
```

The above command sets MariaDB `root` account password to `<your-root-password>`, MariaDB `user` account password to `<your-user-password>` and MariaDB `user` account name to `<your-user-name>`.

<!-- Required -->

## Licenses

All licenses for the Clear Linux* Project and distributed software can be found
at https://clearlinux.org/terms-and-policies
