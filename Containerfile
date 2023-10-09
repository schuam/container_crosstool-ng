FROM ubuntu:22.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        autoconf \
        automake \
        bison \
        bzip2 \
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

