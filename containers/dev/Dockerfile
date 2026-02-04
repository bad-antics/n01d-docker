#╔════════════════════════════════════════════════════════════════════════════════╗
#║                         N01D DEV CONTAINER                                     ║
#║                   Multi-language Development | bad-antics                     ║
#╚════════════════════════════════════════════════════════════════════════════════╝

FROM ubuntu:24.04

LABEL maintainer="bad-antics"
LABEL description="N01D Dev - Multi-language development environment"

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm-256color

# Install base packages
RUN apt-get update && apt-get install -y \
    build-essential git curl wget \
    python3 python3-pip python3-venv \
    nodejs npm \
    golang-go \
    rustc cargo \
    neovim tmux zsh \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python tools
RUN pip3 install --break-system-packages \
    poetry black flake8 mypy pytest

# Install Node.js tools
RUN npm install -g yarn pnpm typescript ts-node

# Create user
RUN useradd -m -s /bin/zsh n01d && \
    echo 'n01d ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER n01d
WORKDIR /home/n01d

# N01D prompt
RUN echo 'PS1="\[\033[0;32m\]┌──[\[\033[1;36m\]DEV\[\033[0;32m\]]─[\[\033[0;37m\]\u\[\033[0;32m\]]─[\[\033[0;34m\]\w\[\033[0;32m\]]\n└──╼ \[\033[0m\]"' >> ~/.bashrc

CMD ["/bin/bash"]
