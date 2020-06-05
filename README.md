# bazarr

<img src="https://raw.githubusercontent.com/hotio/docker-bazarr/master/img/bazarr.png" alt="Logo" height="130" width="130">

![Base](https://img.shields.io/badge/base-alpine-blue)
[![GitHub](https://img.shields.io/badge/source-github-lightgrey)](https://github.com/hotio/docker-bazarr)
[![Docker Pulls](https://img.shields.io/docker/pulls/hotio/bazarr)](https://hub.docker.com/r/hotio/bazarr)
[![Discord](https://img.shields.io/discord/610068305893523457?color=738ad6&label=discord&logo=discord&logoColor=white)](https://discord.gg/3SnkuKp)
[![Upstream](https://img.shields.io/badge/upstream-project-yellow)](https://github.com/morpheus65535/bazarr)

## Starting the container

Just the basics to get the container running:

```shell
docker run --rm --name bazarr -p 6767:6767 -v /<host_folder_config>:/config hotio/bazarr
```

The environment variables below are all optional, the values you see are the defaults.

```shell
-e PUID=1000
-e PGID=1000
-e UMASK=002
-e TZ="Etc/UTC"
-e ARGS=""
-e DEBUG="no"
```

## Tags

| Tag                | Description                            | Build Status                                                                                                                                                      | Last Updated                                                                                                                                                                          |
| -------------------|----------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| latest             | The same as `stable`                   |                                                                                                                                                                   |                                                                                                                                                                                       |
| stable             | Stable version                         | [![Build Status](https://cloud.drone.io/api/badges/hotio/docker-bazarr/status.svg?ref=refs/heads/stable)](https://cloud.drone.io/hotio/docker-bazarr)             | [![GitHub last commit (branch)](https://img.shields.io/github/last-commit/hotio/docker-bazarr/stable)](https://github.com/hotio/docker-bazarr/commits/stable)                         |
| unstable           | Unstable version, development branch   | [![Build Status](https://cloud.drone.io/api/badges/hotio/docker-bazarr/status.svg?ref=refs/heads/unstable)](https://cloud.drone.io/hotio/docker-bazarr)           | [![GitHub last commit (branch)](https://img.shields.io/github/last-commit/hotio/docker-bazarr/unstable)](https://github.com/hotio/docker-bazarr/commits/unstable)                     |
| stable-ffsubsync   | Stable version, ffsubsync included     | [![Build Status](https://cloud.drone.io/api/badges/hotio/docker-bazarr/status.svg?ref=refs/heads/stable-ffsubsync)](https://cloud.drone.io/hotio/docker-bazarr)   | [![GitHub last commit (branch)](https://img.shields.io/github/last-commit/hotio/docker-bazarr/stable-ffsubsync)](https://github.com/hotio/docker-bazarr/commits/stable-ffsubsync)     |
| unstable-ffsubsync | Unstable version, ffsubsync included   | [![Build Status](https://cloud.drone.io/api/badges/hotio/docker-bazarr/status.svg?ref=refs/heads/unstable-ffsubsync)](https://cloud.drone.io/hotio/docker-bazarr) | [![GitHub last commit (branch)](https://img.shields.io/github/last-commit/hotio/docker-bazarr/unstable-ffsubsync)](https://github.com/hotio/docker-bazarr/commits/unstable-ffsubsync) |

You can also find tags that reference a commit or version number.

## Configuration location

Your bazarr configuration inside the container is stored in `/config/app`, to migrate from another container, you'd probably have to move your files from `/config` to `/config/app`.

## FFsubsync

The tags `stable-ffsubsync` and `unstable-ffsubsync` come bundled with [ffsubsync](https://github.com/smacke/ffsubsync). Add the below post-processing command to your Bazarr settings to execute `ffsubsync` on subtitle download, adjust for your own personal needs according the subsync docs.

```shell
ffsubsync "{{episode}}" -i "{{subtitles}}" -o "{{subtitles}}"
```

## Executing your own scripts

If you have a need to do additional stuff when the container starts or stops, you can mount your script with `-v /docker/host/my-script.sh:/etc/cont-init.d/99-my-script` to execute your script on container start or `-v /docker/host/my-script.sh:/etc/cont-finish.d/99-my-script` to execute it when the container stops. An example script can be seen below.

```shell
#!/usr/bin/with-contenv bash

echo "Hello, this is me, your script."
```

## Troubleshooting a problem

By default all output is redirected to `/dev/null`, so you won't see anything from the application when using `docker logs`. Most applications write everything to a log file too. If you do want to see this output with `docker logs`, you can use `-e DEBUG="yes"` to enable this.
