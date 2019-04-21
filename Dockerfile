FROM hotio/base

ARG DEBIAN_FRONTEND="noninteractive"

ENV APP="Bazarr"
EXPOSE 6767
HEALTHCHECK --interval=60s CMD curl -fsSL http://localhost:6767 || exit 1

# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        libxml2 libxslt1.1 \
        python-pip python-setuptools libxml2-dev libxslt1-dev && \
    pip --no-cache-dir install gevent==1.4.0 lxml==4.3.0 && \
# clean up
    apt purge -y python-pip python-setuptools libxml2-dev libxslt1-dev && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

# install app
# https://github.com/morpheus65535/bazarr/releases
RUN curl -fsSL "https://github.com/morpheus65535/bazarr/archive/v0.7.3.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
