# n01d-osint - OSINT & Recon Container  
FROM python:3.11-slim

LABEL maintainer="bad-antics"
LABEL description="NullSec OSINT tools container"

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    whois \
    dnsutils \
    nmap \
    curl \
    wget \
    jq \
    chromium \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    shodan \
    censys \
    theHarvester \
    holehe \
    socialscan \
    whatsmyname \
    maigret \
    sherlock-project \
    dnsdumpster \
    httpx \
    rich

WORKDIR /data

ENTRYPOINT ["/bin/bash"]
