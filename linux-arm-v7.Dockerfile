FROM hotio/base@sha256:faf26d226b8166352c02269ba37e1032845b9cb6d2f13847c759d0f29a46fc35

EXPOSE 6767

RUN apk add --no-cache ffmpeg python3 py3-lxml py3-numpy unrar unzip

ARG VERSION
RUN curl -fsSL "https://github.com/morpheus65535/bazarr/archive/v${VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin" "${APP_DIR}/screenshot" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
