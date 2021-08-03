FROM debian:buster-slim AS builder

LABEL \
    org.opencontainers.image.title="nebula" \
    org.opencontainers.image.authors="akafeng <i@sjy.im>"

ARG NEBULA_VERSION="1.4.0"
ARG NEBULA_CHECKSUM="d1ef37ca4d676f00df0ec83911cc2d9f1e70edc70651589210f9e97c68891b9b"
ARG NEBULA_URL="https://github.com/slackhq/nebula/releases/download/v${NEBULA_VERSION}/nebula-linux-amd64.tar.gz"

RUN set -eux \
    && apt-get update -qyy \
    && apt-get install -qyy --no-install-recommends --no-install-suggests \
        ca-certificates \
        wget \
    && rm -rf /var/lib/apt/lists/* /var/log/* \
    \
    && wget -O nebula.tar.gz ${NEBULA_URL} \
    && echo "${NEBULA_CHECKSUM} nebula.tar.gz" | sha256sum -c \
    && tar -xzvf nebula.tar.gz -C /usr/local/bin/ \
    && rm -rf nebula.tar.gz \
    && nebula -version

######

FROM debian:buster-slim

LABEL \
    org.opencontainers.image.title="nebula" \
    org.opencontainers.image.authors="akafeng <i@sjy.im>"

COPY --from=builder /usr/local/bin/ /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/nebula"]
CMD ["-config", "/etc/nebula/config.yaml"]
