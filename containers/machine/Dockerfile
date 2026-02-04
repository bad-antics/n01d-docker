# n01d-machine - VM Manager Container
FROM ubuntu:22.04

LABEL maintainer="bad-antics"
LABEL description="n01d-machine - VM management with sandboxing"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    qemu-system-x86 \
    qemu-utils \
    libvirt-daemon-system \
    virt-manager \
    bridge-utils \
    iptables \
    tor \
    openvpn \
    wireguard-tools \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir \
    libvirt-python \
    rich \
    click

WORKDIR /vms

ENTRYPOINT ["/bin/bash"]
