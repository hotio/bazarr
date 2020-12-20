FROM ghcr.io/hotio/base@sha256:f9b216e4d1e5dddef8dd0dbe0cbd42ff017076980024d2f716c47e91ce180758

EXPOSE 6767

RUN apk add --no-cache ffmpeg python3 py3-lxml py3-numpy unrar unzip && \
    apk add --no-cache --virtual=build-dependencies py3-pip py3-setuptools gcc python3-dev musl-dev && \
    pip3 install --no-cache-dir --upgrade \
        webrtcvad-wheels>=2.0.10 && \
    apk del --purge build-dependencies

ARG VERSION
RUN curl -fsSL "https://github.com/morpheus65535/bazarr/archive/v${VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    rm -rf "${APP_DIR}/bin" "${APP_DIR}/screenshot" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
