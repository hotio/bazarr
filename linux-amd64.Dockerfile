FROM ghcr.io/hotio/base@sha256:00555ada893a084a1550cbbb95a0172d521c772643868585ea97366e938457d7

EXPOSE 6767

RUN apk add --no-cache ffmpeg python3 py3-lxml py3-numpy unrar unzip && \
    apk add --no-cache --virtual=build-dependencies py3-pip py3-setuptools gcc python3-dev musl-dev && \
    pip3 install --no-cache-dir --upgrade \
        webrtcvad-wheels>=2.0.10 && \
    apk del --purge build-dependencies

ARG VERSION
ARG PACKAGE_VERSION=${VERSION}
ARG BBRANCH
RUN mkdir "${APP_DIR}/bin" && \
    curl -fsSL "https://github.com/morpheus65535/bazarr/archive/v${VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin/bin" "${APP_DIR}/bin/screenshot" && \
    echo -e "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=[hotio](https://github.com/hotio)\nUpdateMethod=Docker\nBranch=${BBRANCH}" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
