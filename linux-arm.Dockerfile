FROM hotio/base@sha256:e604d4296f9fbc0c642871938948d1585a9f1ee4a9ee627167f3ef5e3ab96463

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 6767

# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        python3-distutils libxml2 libxslt1.1 ffmpeg \
        python3-pip python3-setuptools build-essential python3-all-dev libxml2-dev libxslt1-dev && \
# https://raw.githubusercontent.com/morpheus65535/bazarr/master/requirements.txt
    pip3 install --no-cache-dir --upgrade lxml && \
# clean up
    apt purge -y python3-pip python3-setuptools build-essential python3-all-dev libxml2-dev libxslt1-dev && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ARG BAZARR_VERSION=9ceca7959c90a34073eeea7592d29a12d47bf274

# install app
RUN curl -fsSL "https://github.com/morpheus65535/bazarr/archive/${BAZARR_VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
