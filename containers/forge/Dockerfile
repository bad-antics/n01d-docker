# n01d-forge - Secure Image Burner Container
FROM python:3.11-slim

LABEL maintainer="bad-antics"
LABEL description="n01d-forge - Secure image burning with encryption support"

RUN apt-get update && apt-get install -y --no-install-recommends \
    cryptsetup \
    parted \
    dosfstools \
    e2fsprogs \
    pv \
    ddrescue \
    hdparm \
    smartmontools \
    lsblk \
    util-linux \
    xxd \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    rich \
    click \
    pyudev \
    cryptography \
    tqdm

WORKDIR /app
COPY --from=ghcr.io/bad-antics/n01d-forge:latest /app /app 2>/dev/null || true

ENTRYPOINT ["/bin/bash"]
