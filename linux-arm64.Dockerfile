ARG UPSTREAM_IMAGE
ARG UPSTREAM_TAG_SHA

FROM ${UPSTREAM_IMAGE}:${UPSTREAM_TAG_SHA}
EXPOSE 6767
ARG IMAGE_STATS
ENV IMAGE_STATS=${IMAGE_STATS} WEBUI_PORTS="6767/tcp"

RUN apk add --no-cache mediainfo ffmpeg python3 py3-lxml py3-numpy py3-gevent py3-cryptography py3-setuptools py3-psycopg2 py3-pillow unzip && \
    apk add --no-cache --virtual=build-dependencies py3-pip gcc python3-dev musl-dev && \
    pip3 install --break-system-packages --no-cache-dir --upgrade \
        "webrtcvad-wheels>=2.0.10" && \
    apk del --purge build-dependencies

ARG VERSION
ARG VERSION_BRANCH
ARG PACKAGE_VERSION=${VERSION}
RUN mkdir "${APP_DIR}/bin" && \
    zipfile="/tmp/app.zip" && curl -fsSL -o "${zipfile}" "https://github.com/morpheus65535/bazarr/releases/download/v${VERSION}/bazarr.zip" && unzip -q "${zipfile}" -d "${APP_DIR}/bin" && rm "${zipfile}" && \
    echo -e "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=hotio\nUpdateMethod=Docker\nBranch=${VERSION_BRANCH}" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
RUN find /etc/s6-overlay/s6-rc.d -name "run*" -execdir chmod +x {} +
