# Clear SDK Container
[![](https://images.microbadger.com/badges/image/clearlinux/clr-sdk.svg)](https://microbadger.com/images/clearlinux/clr-sdk "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/clearlinux/clr-sdk.svg)](https://microbadger.com/images/clearlinux/clr-sdk "Get your own version badge on microbadger.com")

This repo provides a Clear Linux* SDK container for running the Clear Linux devloper tools. This container will allow you to use the [mixer tool](https://clearlinux.org/features/mixer) on your Linux host.

> ### :warning: **IMPORTANT NOTE:**
> As of `mixer` version `5.0.0`, you **must** run `mixer` with the `--native`
> flag inside the `clr-sdk` container. This is because `mixer` now attempts to
> automatically run build commands within a Docker container containing the
> correct toolchain version for the mix you are building. This is not possible
> if you are already running within the `clr-sdk` container. The `--native` flag
> foregoes this container launch, allowing the build to proceed as normal.
>
> If you _need_ this containerized `mixer` behavior to build across formats, it
> is possible to mount the host system's Docker socket when you launch the
> container (i.e., passing `-v /var/run/docker.sock:/var/run/docker.sock` to
> your `docker run`). This has the effect of the in-container Docker actually
> spawning _sibling_ containers on the host system, rather than _child_
> containers within the `clr-sdk` container. In this case, the workdir path
> _inside_ the container must match the path on the host, as it is the host's
> Docker daemon that will be interpreting the path.

# Build
## Building Locally 

```
docker build -t clearlinux/clr-sdk .
```
> #### Note:
> If you are behind a firewall, you may need to pass the `--network host`,
> `--build-arg http_proxy=http://<proxy>:<port>`,
> `--build-arg https_proxy=https://<proxy>:<port>`, and/or
> `--build-arg no_proxy=http://<proxy>:<port>`, flags to `docker build` to
> configure your proxy.

#### Optional Build ARGs
* `--build-arg swupd_args` specifies [SWUPD](https://clearlinux.org/documentation/swupdate_how_to_run_the_updater.html) flags passed to the update during build.
## Pulling from Dockerhub
```
docker pull clearlinux/clr-sdk
```

# Run
* **Create a mix directory**
  
  The directory you create will be used for the output created while using the container.
  ```
  mkdir -p /home/myuser/mix
  ```
  *It is important that you are the owner of this directory.* The owner of the
  directory is what determines the user id used inside the container. If you
  are not the owner of the directory, you may not have access to the files the
  container creates.
* **Running the Docker container**
  
  Assuming you created the mix directory as described above, the command t
o  run the Docker container would be:
  ```
  docker run --rm -it -v /home/myuser/mix:/home/clr/mix clearlinux/clr-sdk --mixdir=/home/clr/mix
  ```
  ### A note on the arguments:
  #### `docker run` arguments
  * `--rm` cleans up and removes the container once you exit it. The files
    generated in the mounted directory will persist on the host.
  * `-it` attaches an interactive terminal.
  * `-v /path/on/host:/path/in/container` bind mounts a directory on the host
    to a path inside the container. Only the files generated in this path 
    inside the container will be accessible on the host or persist after
    the container has exited. The container path will be automatically
    generated within the container if it doesn't already exist, and will
    replace whatever may already be there, so _use caution_.
  * If you plan to run `sudo mixer build image` inside the container, you
    must additionally pass `--privileged -v /dev:/dev` to `docker run`. This is
    because `mixer build image` needs to mount a loopback device for generating
    the image filesystem. The `-v /dev:/dev` bind mount is due to an [outstanding
    issue](https://github.com/moby/moby/issues/27886) where loopback devices
    created within the container are not visible within the container.
    > ### :warning: **IMPORTANT NOTE:**
    > Running the container in this way can have **serious side effects** on
    > your host machine, so only use these flags for this specific command. **Do
    > not run the container this way as your regular work flow.**
    >
    > * `--privileged` permits the container to create the loopback device, but
    >   also removes other security limitations normally placed on containers.
    > * `-v /dev:/dev` permits the container to see the loopback device, but
    >   also gives the container direct access to the _host's_ entire device
    >   directory, including all mounted drives.
  * If you are behind a firewall, you may need to pass the `--network host`
    flag to `docker run`, and then set your `http_proxy` and `https_proxy`
    environment variables within the container to configure your proxy.
  * Please see note above about mounting the host system's Docker socket if
    you cannot use the `--native` flag when running `mixer`.
  #### Container arguments
  * `-d`|`--mixdir` tells the startup script what directory you mounted using
    the `-v` option above. The owner UID and GID of this directory will be
    used for user inside the container. This is also the active directory when
    the container runs. Omitting this argument will result in a default user
    id and active directory, _even if you mounted a directory with -v_. This
    can be useful, but is likely not what you want, and may cause the container
    user to not have permission to access the mounted mix directory.
  * `--id` manually sets the UID and GID for the user inside the container. 
    Should be in the form UID:GID. Takes precedence over id inferred by
    mixdir argument. This may cause the container user to not have permission
    to access the mounted mix directory.
  
  At this point, you should be able to run the commands described in the
  [mixer guide](https://clearlinux.org/documentation/clear-linux/guides/maintenance/mixer.html).
  **Please see the note above about the `--native` flag.**
