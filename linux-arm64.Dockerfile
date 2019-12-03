FROM hotio/base

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

ARG BAZARR_VERSION=2ecd21beb0bf4fc6c3a5edee58e873ca4102b843

# install app
RUN curl -fsSL "https://github.com/morpheus65535/bazarr/archive/${BAZARR_VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
