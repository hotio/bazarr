FROM hotio/base@sha256:7f7cae79a19448a4b2ecbef82eb6d7df34b63daff3494891135cea6dbeb47220

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 6767

# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        libxml2 libxslt1.1 unrar ffmpeg \
        python-pip build-essential python-all-dev python-setuptools libxml2-dev libxslt1-dev && \
# https://raw.githubusercontent.com/morpheus65535/bazarr/master/requirements.txt
    pip --no-cache-dir install lxml==4.3.0 && \
# clean up
    apt purge -y python-pip build-essential python-all-dev python-setuptools libxml2-dev libxslt1-dev && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ARG BAZARR_VERSION=5dc8facae7dfe5b50d8f35c92750f4c07e5d6e79

# install app
RUN curl -fsSL "https://github.com/morpheus65535/bazarr/archive/${BAZARR_VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
