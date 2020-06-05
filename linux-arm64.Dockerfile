FROM hotio/base@sha256:5c748f472fd4dda9c2332dbce09046f9b419d6776083ec17df1d4d8370eb5a0b

EXPOSE 6767

RUN apk add --no-cache --virtual=build-dependencies g++ gcc libxml2-dev libxslt-dev python3-dev py3-pip && \
    apk add --no-cache ffmpeg libxml2 libxslt python3 unrar unzip && \
    pip3 install --no-cache-dir --upgrade lxml && \
    apk del --purge build-dependencies

ARG BAZARR_VERSION
RUN curl -fsSL "https://github.com/morpheus65535/bazarr/archive/${BAZARR_VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
