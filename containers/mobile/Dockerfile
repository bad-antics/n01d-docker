# n01d-mobile - NullKia Mobile Security Container
FROM ubuntu:22.04

LABEL maintainer="bad-antics"
LABEL description="NullKia mobile security testing environment"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    android-tools-adb \
    android-tools-fastboot \
    openjdk-17-jdk \
    apktool \
    dex2jar \
    jadx \
    python3 \
    python3-pip \
    git \
    curl \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir \
    frida-tools \
    objection \
    drozer \
    androguard \
    rich

# Install jadx
RUN wget -q https://github.com/skylot/jadx/releases/latest/download/jadx-1.4.7.zip -O /tmp/jadx.zip \
    && unzip /tmp/jadx.zip -d /opt/jadx \
    && rm /tmp/jadx.zip

ENV PATH="/opt/jadx/bin:${PATH}"

WORKDIR /data

ENTRYPOINT ["/bin/bash"]
