# syntax=docker/dockerfile:1.7

FROM alpine:3.24 AS build

ARG UNFS3_COMMIT=ec1660ba33c80d5c67131e163e68834c1a10e243

RUN apk add --no-cache \
      autoconf \
      automake \
      bison \
      build-base \
      flex \
      git \
      libtirpc-dev \
      libtool \
      linux-headers

WORKDIR /src
RUN git init . \
    && git remote add origin https://github.com/unfs3/unfs3.git \
    && git fetch --depth=1 origin "${UNFS3_COMMIT}" \
    && git checkout --detach FETCH_HEAD \
    && test "$(git rev-parse HEAD)" = "${UNFS3_COMMIT}"

RUN ./bootstrap \
    && ./configure --prefix=/usr/local \
    && make -j"$(nproc)" \
    && make install

FROM alpine:3.24

RUN apk add --no-cache libtirpc

COPY --from=build /usr/local/sbin/unfsd /usr/local/sbin/unfsd

LABEL org.opencontainers.image.source="https://github.com/cyrahs/unfs3" \
      org.opencontainers.image.title="unfs3" \
      org.opencontainers.image.version="0.11.0"

ENTRYPOINT ["/usr/local/sbin/unfsd"]
