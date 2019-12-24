FROM hotio/base@sha256:72d865d31839031503fbad233f46da25b5cd386371e639cb10eaa24d461a7c93

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

ARG BAZARR_VERSION=cca888fa940424bb7c2e0fc335a165a8dcf7aa9b

# install app
RUN curl -fsSL "https://github.com/morpheus65535/bazarr/archive/${BAZARR_VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
