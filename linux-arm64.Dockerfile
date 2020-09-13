FROM hotio/base@sha256:862937c0d795328dea8b83d5ee04a9aa82e729adb939e84f8b79f8123800cea5

EXPOSE 6767

RUN apk add --no-cache ffmpeg python3 py3-lxml py3-numpy unrar unzip

ARG VERSION
RUN curl -fsSL "https://github.com/morpheus65535/bazarr/archive/${VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin" "${APP_DIR}/screenshot" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
