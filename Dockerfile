FROM debian:buster-slim AS builder

LABEL maintainer="akafeng <i@sjy.im>"

ARG NEBULA_VERSION="1.3.0"
ARG NEBULA_CHECKSUM="a82e0c6ab14dd2c5af921ae3051a88493ac053a5ece77eaa9e87a0543fd3d89b"
ARG NEBULA_URL="https://github.com/slackhq/nebula/releases/download/v${NEBULA_VERSION}/nebula-linux-amd64.tar.gz"

RUN set -eux \
    && apt-get update -qyy \
    && apt-get install -qyy --no-install-recommends --no-install-suggests \
        ca-certificates \
        wget \
    \
    && wget -O nebula.tar.gz ${NEBULA_URL} \
    && echo "${NEBULA_CHECKSUM} nebula.tar.gz" | sha256sum -c \
    && tar -xzvC /usr/local/bin/ -f nebula.tar.gz \
    && rm -rf nebula.tar.gz \
    && nebula -version

######

FROM debian:buster-slim

LABEL maintainer="akafeng <i@sjy.im>"

COPY --from=builder /usr/local/bin/ /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/nebula"]
CMD ["-config", "/etc/nebula/config.yaml"]
