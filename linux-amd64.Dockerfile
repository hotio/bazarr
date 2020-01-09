FROM hotio/base@sha256:4105128e6d8427bcd9c45d24141e1fad84d66ccc8716d380c6e89da17822963f

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 6767

# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        python3-distutils libxml2 libxslt1.1 ffmpeg \
        python3-pip python3-setuptools && \
# https://raw.githubusercontent.com/morpheus65535/bazarr/master/requirements.txt
    pip3 install --no-cache-dir --upgrade lxml && \
# clean up
    apt purge -y python3-pip python3-setuptools && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ARG BAZARR_VERSION=0.8.4

# install app
RUN curl -fsSL "https://github.com/morpheus65535/bazarr/archive/v${BAZARR_VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
