FROM hotio/base@sha256:cba106376e466f9b67d3b50d6b8906752cf05afa9f5686fdda5c10e64e516051

EXPOSE 6767

RUN apk add --no-cache ffmpeg python3 py3-lxml py3-numpy unrar unzip

ARG BAZARR_VERSION
RUN curl -fsSL "https://github.com/morpheus65535/bazarr/archive/${BAZARR_VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin" "${APP_DIR}/screenshot" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /

ARG LABEL_CREATED
LABEL org.opencontainers.image.created=$LABEL_CREATED
ARG LABEL_TITLE
LABEL org.opencontainers.image.title=$LABEL_TITLE
ARG LABEL_REVISION
LABEL org.opencontainers.image.revision=$LABEL_REVISION
ARG LABEL_SOURCE
LABEL org.opencontainers.image.source=$LABEL_SOURCE
ARG LABEL_VENDOR
LABEL org.opencontainers.image.vendor=$LABEL_VENDOR
ARG LABEL_URL
LABEL org.opencontainers.image.url=$LABEL_URL
ARG LABEL_VERSION
LABEL org.opencontainers.image.version=$LABEL_VERSION
