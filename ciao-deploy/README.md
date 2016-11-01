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
git clone https://github.com/clearlinux/clear-config-management.git
```

Setup your cluster configuration
--------------------------------
You may need to edit `clear-config-management/examples/ciao/group_vars/all`
and `clear-config-management/examples/ciao/hosts` to suit your cluster
setup needs.

For more detailed instructions you may want to check
[Deploying ciao via automation](https://clearlinux.org/documentation/ciao-deploy.html)
documentation.

Run the Ciao-deploy Container
----------------------------
```
docker run -v $(pwd)/clear-config-management/examples/ciao:/root/ciao \
    -it clearlinux/ciao-deploy

```

If you have setup your ssh key for the ansible setup, you may want to use it
in your ciao-deploy container:

```
docker run -v $(pwd)/clear-config-management/examples/ciao:/root/ciao \
    -v /path/to/your/.ssh/key:/root/.ssh/key \
    -it clearlinux/ciao-deploy
```


Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://clearlinux.org/documentation/swupdate_how_to_run_the_updater.html) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#/arg
