FROM cr.hotio.dev/hotio/base@sha256:51b4032b5584538d5987a759e74201ef2626502750efe77d4f7124eb56284c4e

EXPOSE 6767

RUN apk add --no-cache ffmpeg python3 py3-lxml py3-numpy py3-gevent py3-cryptography py3-setuptools unrar unzip && \
    apk add --no-cache --virtual=build-dependencies py3-pip gcc python3-dev musl-dev && \
    pip3 install --no-cache-dir --upgrade \
        "gevent-websocket>=0.10.1" \
        "webrtcvad-wheels>=2.0.10" && \
    apk del --purge build-dependencies

ARG VERSION
ARG PACKAGE_VERSION=${VERSION}
ARG BBRANCH
RUN mkdir "${APP_DIR}/bin" && \
    zipfile="/tmp/app.zip" && curl -fsSL -o "${zipfile}" "https://github.com/morpheus65535/bazarr/releases/download/v${VERSION}/bazarr.zip" && unzip -q "${zipfile}" -d "${APP_DIR}/bin" && rm "${zipfile}" && \
    echo -e "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=[hotio](https://github.com/hotio)\nUpdateMethod=Docker\nBranch=${BBRANCH}" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
