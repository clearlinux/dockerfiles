# Clear Linux* OS `node` Helm Charts

<!-- Required -->
## What is this image?

`clearlinux/node` is a Docker image with `node` running on top of the [official clearlinux base image](https://hub.docker.com/_/clearlinux).

> [Node](https://nodejs.org/en/) is a JavaScript runtime built on Chrome's V8 JavaScript engine.

For other Clear Linux* OS based container images, see: https://hub.docker.com/u/clearlinux

## Why use a clearlinux based image?

> [Clear Linux* OS](https://clearlinux.org/) is an open source, rolling release Linux distribution optimized for performance and security, from the Cloud to the Edge, designed for customization, and manageability.

Clear Linux* OS based container images use:

- Optimized libraries that are compiled with latest compiler versions and flags.
- Software packages that follow upstream source closely and update frequently.
- An aggressive security model and best practices for CVE patching.
- A multi-staged build approach to keep a reduced container image size.
- The same container syntax as the official images to make getting started easy.

To learn more about Clear Linux* OS, visit: [https://clearlinux.org](https://clearlinux.org/).

<!-- Required -->

## Installing the Node Chart

Download the node chart and install the chart with the release name ` my-release` 

```
$ helm install --name my-release node
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

The following table lists the configurable parameters of the node chart and their default values.

| Parameter                      | Description                                 | Default                     |
| ------------------------------ | ------------------------------------------- | --------------------------- |
| `image.replicaCount`           | node pod count                              | `2`                         |
| `image.repository`             | node image repository                       | `docker.io/clearlinux/node` |
| `image.imagepullPolicy`        | node image pull policy                      | `IfNotPresent`              |
| `service.type`                 | node service type                           | `NodePort`                  |
| `service.port`                 | node service port                           | `80`                        |
| `service.targetPort`           | node service targetPort                     | `80`                        |
| `service.nodePort`             | node service nodePort                       | `30001`                     |
| `config.enabled`               | If apply custom config file to node service | `True`                      |
| `config.content`               | custom file content                         | `your own custom conf`      |
| `config.name`                  | config volume name                          | `nodejs-mount`              |
| `ingress.enabled`              | Enable ingress controller resource          | `false`                     |
| `ingress.hosts[0].host`        | Host to your Node installation              | `chart-example.local`       |
| `ingress.hosts[0].paths`       | Path within the url structure               | `[]`                        |
| `ingress.hosts[0].tls`         | Utilize TLS backend in ingress              | `[]`                        |
| `ingress.hosts[0].annotations` | Annotations for this host's ingress record  | `{}`                        |

<!-- Required -->

## Licenses

All licenses for the Clear Linux* Project and distributed software can be found
at https://clearlinux.org/terms-and-policies
