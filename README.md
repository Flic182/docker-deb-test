# Docker Deb Test

### Dependencies
#### External
1. [curl](https://curl.haxx.se/)
2. [docker](https://docs.docker.com)
3. [docker-compose](https://docs.docker.com/compose/)
4. [yq](http://http://mikefarah.github.io/yq/)

### About
This is a basic application that can take both local and remote *.deb* files,
create a simple Docker Linux image and install the *.deb* files into it.

**Note:**  One or more *.deb* files are required.  They can be local, remote, or
a mixture of the two.

### Running the program
The following commands should be run from the project root, where
`docker-compose.yml` lives.

Run the program with:

```
./UnpackDeb.sh -l <local_deb_file(s)> -r <remote_deb_files> -b
```

...where file names are separated by whitespace and *-b* directs the script to
rebuild the image and container, after first tearing down the volume attached to
a container from a previous run.

When the container is running, it is possible to log into it and check the
*.deb* packages have correctly installed with the following:

```
docker exec -it <container_name> /usr/bin/env bash
```

**Note:**  The default `<container_name>` is *deb-test*, as discussed in the
[Docker configuration](#docker-configuration) section.

### Clean up
The container can be shut down from the project root with:

```
docker-compose down
```

The Docker container and images from which the container is built can be removed
in one go with:

```
./Cleanup.sh
```

### Docker configuration
The following items are set in the `docker-compose.yml` file:

* `BASE_IMAGE` - The base Docker Linux image, set to `ubuntu:16.04`.
  If not set, `build/Dockerfile` specifies a default image of `debian:latest`.
  Be careful to use a flavour of Linux that is apt-compatible, or you will need
  to make appropriate adjustments to the `build/InitEnv.sh` script.  **In
  particular,** `alpine` **images use** `apk` **rather than** `apt` **for
  package management.**
* `EXTRA_INSTALLS` - If there are any additional dependencies (`apt` packages)
  required by the *.deb* file(s) that are not part of the base Linux image,
  they should be mentioned here.  This is a whitespace-separated list - quoting
  is **not** required.
* `container_name` - Set to *deb-test*, but this can be altered if another name
  is preferred.
* `image` - Set to *deb_test_image*, but again can be altered if another name is
  preferred.
* Volume mapping `build/deb-files` to `/opt` - It is possible to manually
  install additional *.deb* files into the running container by copying them to
  `build/deb-files`, which will place them in `/opt` in the container.  The
  `Entrypoint.sh` script demonstrates how to unpack *.deb* files in this
  directory.  Changing the volume mapping is not recommended, as alterations to
  both the `UnpackDeb.sh` and `Cleanup.sh` scripts will be required for them to
  continue to bring up and tear down the container properly.

There are other items set in this file which should not be changed.  Alter them
at your own risk.