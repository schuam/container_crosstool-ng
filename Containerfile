ARG BASE_OS=ubuntu
ARG BASE_OS_VERSION=22.04
ARG BASE_IMAGE=${BASE_OS}:${BASE_OS_VERSION}

FROM ${BASE_IMAGE}

ARG CTNG_NAME=crosstool-ng
ARG CTNG_VERSION=1.26.0
ARG CTNG_VERSION_GIT_TAG=${CTNG_NAME}-${CTNG_VERSION}

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        autoconf \
        automake \
        bison \
        bzip2 \
        ca-certificates \
        cmake \
        flex \
        g++ \
        gawk \
        gcc \
        gettext \
        git \
        gperf \
        help2man \
        libncurses5-dev \
        libstdc++6 \
        libtool \
        libtool-bin \
        make \
        patch \
        python3-dev \
        rsync \
        texinfo \
        unzip \
        wget \
        xz-utils \
    && apt-get autoremove --purge -y \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/crosstool-ng/crosstool-ng.git \
    && cd crosstool-ng \
    && git checkout ${CTNG_VERSION_GIT_TAG} \
    && ./bootstrap \
    && ./configure --prefix=/usr/local \
    && make \
    && make install \
    && rm -rf /crosstool-ng

ENV CT_ALLOW_BUILD_AS_ROOT_SURE=1
ENV CT_PREFIX=/data/x-tools
VOLUME [ "/data" ]
WORKDIR /data

