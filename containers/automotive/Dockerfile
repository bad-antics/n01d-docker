# n01d-automotive - BlackFlag ECU Container
FROM python:3.11-slim

LABEL maintainer="bad-antics"
LABEL description="BlackFlag ECU - Automotive security testing"

RUN apt-get update && apt-get install -y --no-install-recommends \
    can-utils \
    iproute2 \
    kmod \
    git \
    build-essential \
    libsdl2-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    python-can \
    cantools \
    udsoncan \
    can-isotp \
    scapy \
    rich \
    click

# Clone BlackFlag ECU tools
RUN git clone --depth 1 https://github.com/bad-antics/blackflag-ecu.git /opt/blackflag-ecu 2>/dev/null || true

ENV PATH="/opt/blackflag-ecu:${PATH}"

WORKDIR /data

ENTRYPOINT ["/bin/bash"]
