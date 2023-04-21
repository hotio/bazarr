ARG UPSTREAM_IMAGE
ARG UPSTREAM_DIGEST_ARM64

FROM ${UPSTREAM_IMAGE}@${UPSTREAM_DIGEST_ARM64}
EXPOSE 6767
VOLUME ["${CONFIG_DIR}"]

ARG VERSION
ARG PACKAGE_VERSION=${VERSION}
ARG BBRANCH
RUN mkdir "${APP_DIR}/bin" && \
    zipfile="/tmp/app.zip" && curl -fsSL -o "${zipfile}" "https://github.com/morpheus65535/bazarr/releases/download/v${VERSION}/bazarr.zip" && unzip -q "${zipfile}" -d "${APP_DIR}/bin" && rm "${zipfile}" && \
    echo -e "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=[hotio](https://github.com/hotio)\nUpdateMethod=Docker\nBranch=${BBRANCH}" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

RUN apk add --no-cache mediainfo ffmpeg python3 py3-pip unzip && \
    apk add --no-cache --virtual=build-dependencies g++ gcc python3-dev musl-dev && \
    pip3 install --upgrade pip && \
    pip3 install -r "${APP_DIR}/bin/requirements.txt" && \
    pip3 install -r "${APP_DIR}/bin/postgres-requirements.txt" && \
    apk del --purge build-dependencies

COPY root/ /
RUN chmod -R +x /etc/cont-init.d/ /etc/services.d/
