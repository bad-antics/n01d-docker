#╔════════════════════════════════════════════════════════════════════════════════╗
#║                         N01D CTF CONTAINER                                     ║
#║                    CTF Challenge Environment | bad-antics                     ║
#╚════════════════════════════════════════════════════════════════════════════════╝

FROM python:3.12-alpine

LABEL maintainer="bad-antics"
LABEL description="N01D CTF - Lightweight CTF environment"

RUN apk add --no-cache \
    build-base gdb binutils file \
    openssl openssl-dev libffi-dev \
    && pip install pwntools pycryptodome z3-solver

WORKDIR /ctf

CMD ["/bin/sh"]
