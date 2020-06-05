FROM hotio/base@sha256:dba94df91a2c476ec1e3717a2f76fd01ef5b9fcf1a1baa0efbac5e3c5b5f77d4

EXPOSE 6767

RUN apk add --no-cache --virtual=build-dependencies g++ gcc libxml2-dev libxslt-dev python3-dev py3-pip && \
    apk add --no-cache ffmpeg libxml2 libxslt python3 unrar unzip && \
    pip3 install --no-cache-dir --upgrade lxml && \
    apk del --purge build-dependencies

ARG BAZARR_VERSION
RUN curl -fsSL "https://github.com/morpheus65535/bazarr/archive/${BAZARR_VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin" "${APP_DIR}/screenshot" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
