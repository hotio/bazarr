FROM cr.hotio.dev/hotio/base@sha256:3db7ec77346db6ba77750276a1a32ea8426bea78509ebb476fd7cbde1e7b8ef6

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
