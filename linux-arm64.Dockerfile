FROM hotio/base@sha256:cba106376e466f9b67d3b50d6b8906752cf05afa9f5686fdda5c10e64e516051

EXPOSE 6767

RUN apk add --no-cache ffmpeg python3 py3-lxml py3-numpy unrar unzip

ARG VERSION
RUN curl -fsSL "https://github.com/morpheus65535/bazarr/archive/${VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin" "${APP_DIR}/screenshot" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
