#!/bin/bash

sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    git \
    libglib2.0-dev \
    libfdt-dev \
    libpixman-1-dev\
    zlib1g-dev \
    ninja-build \
    libaio-dev libbluetooth-dev libcapstone-dev libbrlapi-dev libbz2-dev \
    libcap-ng-dev libcurl4-gnutls-dev libgtk-3-dev \
    libibverbs-dev libjpeg8-dev libncurses5-dev libnuma-dev \
    librbd-dev librdmacm-dev \
    libsasl2-dev libsdl2-dev libseccomp-dev libsnappy-dev libssh-dev \
    libvde-dev libvdeplug-dev libvte-2.91-dev libxen-dev liblzo2-dev \
    valgrind xfslibs-dev \
    libnfs-dev libiscsi-dev \
    libgcrypt20-dev \
    python3-venv \
    pip \
    gcc \
    vim

# check env.
if [ ! -r /.dockerenv ]; then
  echo "Usage  : $0 must run inside docker!"
  exit 1
fi

if [ -d /qemu ]; then
  cd /qemu
else
  echo "qemu is not mounted in docker!"
  exit 1
fi

./configure --target-list=xtensa-softmmu \
  --enable-gcrypt \
  --enable-slirp \
  --enable-debug --enable-sanitizers \
  --enable-sdl \
  --disable-strip --disable-user \
  --disable-capstone --disable-vnc \
  --disable-gtk

ninja -C build
