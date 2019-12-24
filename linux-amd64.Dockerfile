FROM hotio/base@sha256:7f7cae79a19448a4b2ecbef82eb6d7df34b63daff3494891135cea6dbeb47220

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 6767

# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        python3 python3-distutils libxml2 libxslt1.1 unrar ffmpeg \
        python3-pip build-essential python3-all-dev python3-setuptools libxml2-dev libxslt1-dev && \
# https://raw.githubusercontent.com/morpheus65535/bazarr/master/requirements.txt
    pip3 --no-cache-dir install lxml==4.3.0 && \
# clean up
    apt purge -y python3-pip build-essential python3-all-dev python3-setuptools libxml2-dev libxslt1-dev && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ARG BAZARR_VERSION=a612335a44531a487862e4aa5e42bcab6a5cf1f8

# install app
RUN curl -fsSL "https://github.com/morpheus65535/bazarr/archive/${BAZARR_VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
