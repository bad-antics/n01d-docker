# n01d-stealth - Ghost Network Stealth Container
FROM golang:1.21-alpine AS builder

RUN apk add --no-cache git
RUN go install github.com/bad-antics/nullsec-ghost@latest 2>/dev/null || true

FROM alpine:latest

LABEL maintainer="bad-antics"
LABEL description="Ghost network stealth & spoofing tools"

RUN apk add --no-cache \
    macchanger \
    iptables \
    nftables \
    tor \
    proxychains-ng \
    python3 \
    py3-pip \
    bash

RUN pip3 install --no-cache-dir --break-system-packages \
    scapy \
    rich

COPY --from=builder /go/bin/* /usr/local/bin/ 2>/dev/null || true

WORKDIR /data

ENTRYPOINT ["/bin/bash"]
