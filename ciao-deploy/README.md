Ciao Deploy
==========
[![](https://images.microbadger.com/badges/image/clearlinux/ciao-deploy.svg)](http://microbadger.com/images/clearlinux/ciao-deploy "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/clearlinux/ciao-deploy.svg)](http://microbadger.com/images/clearlinux/ciao-deploy "Get your own version badge on microbadger.com")

This provides a ciao deployment container.

Build
-----
```
docker build -t clearlinux/ciao-deploy .
```

Or just pull it from Dockerhub
------------------------------
```
docker pull clearlinux/ciao-deploy
```

Clone the ciao example deployment
---------------------------------
```
git clone https://github.com/01org/ciao.git
```

Setup your cluster configuration
--------------------------------
You may need to edit `ciao/_DeploymentAndDistroPackaging/ansible/group_vars/all`
and `ciao/_DeploymentAndDistroPackaging/ansible/hosts` to suit your cluster
setup needs.

For more detailed instructions you may want to check
[Deploying ciao via automation](https://clearlinux.org/documentation/ciao-deploy.html)
documentation.

Run the Ciao-deploy Container
----------------------------
You will need to use an ssh key to manage the remote nodes. Replace
`/path/to/your/.ssh/key` with your private ssh key filename (notice it
must be an absolute path).

```
docker run --privileged -v /dev/:/dev/ \
    -v $(pwd)/ciao:/root/ciao \
    -v /path/to/your/.ssh/key:/root/.ssh/key \
    -it clearlinux/ciao-deploy
```

**Note**:

The cotainer needs `–privileged -v /dev/:/dev/` in order to install
your certificates in the
[CNCI image](https://github.com/01org/ciao/tree/master/networking/ciao-cnci-agent#cnci-agent).
To learn more about the Docker options used, please refer to the
[Docker* documentation](https://docs.docker.com/engine/reference/commandline/run/).

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://clearlinux.org/documentation/swupdate_how_to_run_the_updater.html) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#/arg
