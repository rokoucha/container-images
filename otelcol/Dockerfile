# syntax=docker/dockerfile:1

ARG target

FROM --platform=$BUILDPLATFORM ghcr.io/open-telemetry/opentelemetry-collector-releases/opentelemetry-collector-builder:0.144.0 AS ocb

FROM --platform=$BUILDPLATFORM golang:1.25 AS builder

COPY --from=ocb /usr/local/bin/ocb /usr/local/bin/ocb

FROM --platform=$BUILDPLATFORM builder AS build

WORKDIR /work

ARG target
ARG TARGETOS
ARG TARGETARCH

RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    --mount=type=bind,source=${target}/manifest.yaml,target=manifest.yaml \
    CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} \
    ocb --config manifest.yaml --ldflags "-s -w"

FROM alpine:3.23 as certificates

RUN apk --update add ca-certificates

FROM scratch

ARG USER_UID=10001
ARG USER_GID=10001

USER ${USER_UID}:${USER_GID}

ARG target

COPY --from=certificates /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --chmod=644 ${target}/config.yaml /etc/otelcol/config.yaml
COPY --from=build /work/build/otelcol /otelcol

ENTRYPOINT ["/otelcol"]
CMD ["--config", "/etc/otelcol/config.yaml"]
