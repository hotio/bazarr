FROM ghcr.io/hotio/base@sha256:2e0b6f00a8e8a9fa817f9d7a1fec641e2329257547d3556fff565f26dc45d2ee

EXPOSE 6767

RUN apk add --no-cache ffmpeg python3 py3-lxml py3-numpy py3-gevent py3-cryptography unrar unzip && \
    apk add --no-cache --virtual=build-dependencies py3-pip py3-setuptools gcc python3-dev musl-dev && \
    pip3 install --no-cache-dir --upgrade \
        gevent-websocket>=0.10.1 \
        webrtcvad-wheels>=2.0.10 && \
    apk del --purge build-dependencies

ARG VERSION
ARG PACKAGE_VERSION=${VERSION}
ARG BBRANCH
RUN mkdir "${APP_DIR}/bin" && \
    zipfile="/tmp/app.zip" && curl -fsSL -o "${zipfile}" "https://github.com/morpheus65535/bazarr/releases/download/v${VERSION}/bazarr.zip" && unzip -q "${zipfile}" -d "${APP_DIR}/bin" && rm "${zipfile}" && \
    echo -e "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=[hotio](https://github.com/hotio)\nUpdateMethod=Docker\nBranch=${BBRANCH}" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
