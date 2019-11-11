# bazarr

[![GitHub](https://img.shields.io/badge/source-github-lightgrey?style=flat-square)](https://github.com/hotio/docker-bazarr)
[![Docker Pulls](https://img.shields.io/docker/pulls/hotio/bazarr?style=flat-square)](https://hub.docker.com/r/hotio/bazarr)
[![Drone (cloud)](https://img.shields.io/drone/build/hotio/docker-bazarr?style=flat-square)](https://cloud.drone.io/hotio/docker-bazarr)

## Starting the container

Just the basics to get the container running:

```shell
docker run --rm --name bazarr -p 6767:6767 -v /tmp/bazarr:/config -e TZ=Etc/UTC hotio/bazarr:unstable
```

The environment variables below are all optional, the values you see are the defaults.

```shell
-e PUID=1000
-e PGID=1000
-e UMASK=022
```

## Tags

| Tag      | Description                          |
| ---------|--------------------------------------|
| latest   | Stable version                       |
| master   | Stable version                       |
| unstable | Unstable version, development branch |

You can also find tags that reference a commit or version number.

## Executing your own scripts

If you have a need to do additional stuff when the container starts or stops, you can mount your script with `-v /docker/host/my-script.sh:/etc/cont-init.d/99-my-script` to execute your script on container start or `-v /docker/host/my-script.sh:/etc/cont-finish.d/99-my-script` to execute it when the container stops. An example script can be seen below.

```shell
#!/usr/bin/with-contenv bash

echo "Hello, this is me, your script."
```
