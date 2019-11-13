# bazarr

[![GitHub](https://img.shields.io/badge/source-github-lightgrey)](https://github.com/hotio/docker-bazarr)
[![Docker Pulls](https://img.shields.io/docker/pulls/hotio/bazarr)](https://hub.docker.com/r/hotio/bazarr)

## Starting the container

Just the basics to get the container running:

```shell
docker run --rm --name bazarr -p 6767:6767 -v /tmp/bazarr:/config -e TZ=Etc/UTC hotio/bazarr
```

The environment variables below are all optional, the values you see are the defaults.

```shell
-e PUID=1000
-e PGID=1000
-e UMASK=022
```

## Tags

| Tag      | Description                                       | Build Status                                                                                                                                            |
| ---------|---------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------|
| latest   | The same as `stable`                              |                                                                                                                                                         |
| stable   | Stable version                                    | [![Build Status](https://cloud.drone.io/api/badges/hotio/docker-bazarr/status.svg?ref=refs/heads/stable)](https://cloud.drone.io/hotio/docker-bazarr)   |
| unstable | Unstable version, development branch              | [![Build Status](https://cloud.drone.io/api/badges/hotio/docker-bazarr/status.svg?ref=refs/heads/unstable)](https://cloud.drone.io/hotio/docker-bazarr) |
| python3  | Unstable version, python3 branch, runs on python3 | [![Build Status](https://cloud.drone.io/api/badges/hotio/docker-bazarr/status.svg?ref=refs/heads/python3)](https://cloud.drone.io/hotio/docker-bazarr)  |
| testing  | Unstable version, python3 branch, runs on python2 | [![Build Status](https://cloud.drone.io/api/badges/hotio/docker-bazarr/status.svg?ref=refs/heads/testing)](https://cloud.drone.io/hotio/docker-bazarr)  |

You can also find tags that reference a commit or version number.

## Executing your own scripts

If you have a need to do additional stuff when the container starts or stops, you can mount your script with `-v /docker/host/my-script.sh:/etc/cont-init.d/99-my-script` to execute your script on container start or `-v /docker/host/my-script.sh:/etc/cont-finish.d/99-my-script` to execute it when the container stops. An example script can be seen below.

```shell
#!/usr/bin/with-contenv bash

echo "Hello, this is me, your script."
```
