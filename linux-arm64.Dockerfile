FROM hotio/base@sha256:a25edd382ae134f0b783b113fbfda7dcdafc1c456ccdfa799e4db1a13fdddeac

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 6767

# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        python3 python3-distutils libxml2 libxslt1.1 unrar ffmpeg \
        python3-pip python3-setuptools build-essential python3-all-dev libxml2-dev libxslt1-dev && \
# https://raw.githubusercontent.com/morpheus65535/bazarr/master/requirements.txt
    pip3 install --no-cache-dir --upgrade lxml==4.3.0 && \
# clean up
    apt purge -y python3-pip python3-setuptools build-essential python3-all-dev libxml2-dev libxslt1-dev && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

# https://github.com/morpheus65535/bazarr/releases
ARG BAZARR_VERSION=0.8.4

# install app
RUN curl -fsSL "https://github.com/morpheus65535/bazarr/archive/v${BAZARR_VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
