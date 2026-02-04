<!--
SEO Keywords: Docker security, Docker pentest, hacking Docker, security Docker stack,
Kali Docker, pentesting Docker, CTF Docker, Docker development environment,
custom Docker, bad-antics Docker, NullSec Docker
-->

<div align="center">

```
 ███╗   ██╗ ██████╗  ██╗██████╗       ██████╗  ██████╗  ██████╗██╗  ██╗███████╗██████╗ 
 ████╗  ██║██╔═══██╗███║██╔══██╗      ██╔══██╗██╔═══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗
 ██╔██╗ ██║██║   ██║╚██║██║  ██║█████╗██║  ██║██║   ██║██║     █████╔╝ █████╗  ██████╔╝
 ██║╚██╗██║██║   ██║ ██║██║  ██║╚════╝██║  ██║██║   ██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗
 ██║ ╚████║╚██████╔╝ ██║██████╔╝      ██████╔╝╚██████╔╝╚██████╗██║  ██╗███████╗██║  ██║
 ╚═╝  ╚═══╝ ╚═════╝  ╚═╝╚═════╝       ╚═════╝  ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
                    [ CUSTOM DOCKER STACK | bad-antics ]
```

### 🐳 Personal Docker Environment with Security & Development Tools

[![GitHub](https://img.shields.io/badge/GitHub-bad--antics-181717?style=for-the-badge&logo=github)](https://github.com/bad-antics)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docker.com)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

**A complete containerized toolkit for security research, development, and hacking.**

</div>

---

## 🎯 Stack Overview

| Container | Purpose | Base |
|-----------|---------|------|
| `n01d-pentest` | Security testing & penetration testing | Kali Linux |
| `n01d-dev` | Development environment | Ubuntu 24.04 |
| `n01d-julia` | Julia security research | Julia official |
| `n01d-ctf` | CTF challenges & practice | Alpine |
| `n01d-proxy` | Network interception | Alpine + mitmproxy |
| `n01d-vpn` | VPN/tunneling | Alpine + WireGuard |
| `n01d-web` | Web app testing | nginx + various |
| `n01d-db` | Database testing | PostgreSQL/MySQL |

---

## 🚀 Quick Start

```bash
# Clone the repo
git clone https://github.com/bad-antics/n01d-docker.git
cd n01d-docker

# Start the full stack
docker compose up -d

# Or just specific services
docker compose up -d n01d-pentest n01d-dev
```

---

## 📦 Containers

### 🔴 n01d-pentest

Full Kali-based pentesting environment with NullSec customizations.

```bash
docker compose run n01d-pentest
```

**Included tools:**
- Network: nmap, masscan, netcat, wireshark-cli
- Web: burpsuite, nikto, sqlmap, gobuster, ffuf
- Exploitation: metasploit, searchsploit, john, hashcat
- Wireless: aircrack-ng, bettercap, wifite
- OSINT: theHarvester, recon-ng, maltego
- NullSec suite tools

### 💻 n01d-dev

Development environment with multiple language support.

```bash
docker compose run n01d-dev
```

**Languages/Tools:**
- Python 3.12 + pip, pipx, poetry
- Node.js 22 + npm, yarn, pnpm
- Rust + cargo
- Go 1.22
- Julia 1.10
- Git, neovim, tmux, zsh

### 🔬 n01d-julia

Julia-focused security research container.

```bash
docker compose run n01d-julia
```

**Packages:**
- SHA.jl, AES.jl, ECC.jl
- Flux.jl for ML security
- HTTP.jl for web testing
- Pcap.jl for packet analysis

### 🏴 n01d-ctf

Lightweight CTF environment.

```bash
docker compose run n01d-ctf
```

**Tools:**
- pwntools, ROPgadget
- gdb + peda/pwndbg
- binwalk, strings, hexdump
- Python crypto libs

### 🔀 n01d-proxy

Network interception proxy.

```bash
docker compose up -d n01d-proxy
# Access mitmproxy web interface at http://localhost:8081
```

### 🔒 n01d-vpn

WireGuard VPN container for tunneling.

```bash
docker compose up -d n01d-vpn
# Configure in ./config/wireguard/
```

---

## 📁 Directory Structure

```
n01d-docker/
├── docker-compose.yml       # Main compose file
├── .env                     # Environment variables
├── containers/
│   ├── pentest/
│   │   ├── Dockerfile
│   │   └── tools.sh
│   ├── dev/
│   │   ├── Dockerfile
│   │   └── setup.sh
│   ├── julia/
│   │   ├── Dockerfile
│   │   └── Project.toml
│   ├── ctf/
│   │   └── Dockerfile
│   ├── proxy/
│   │   └── Dockerfile
│   └── vpn/
│       └── Dockerfile
├── config/
│   ├── wireguard/
│   ├── burpsuite/
│   └── mitmproxy/
├── data/
│   ├── wordlists/
│   ├── exploits/
│   └── loot/
└── scripts/
    ├── start-stack.sh
    ├── stop-stack.sh
    └── backup.sh
```

---

## ⚙️ Configuration

### Environment Variables

Copy `.env.example` to `.env` and configure:

```bash
# Network
N01D_SUBNET=172.28.0.0/16
N01D_GATEWAY=172.28.0.1

# Proxy
PROXY_PORT=8080
PROXY_WEB_PORT=8081

# VPN
WG_PORT=51820

# Volumes
DATA_PATH=./data
CONFIG_PATH=./config
```

### Custom Wordlists

Mount your wordlists:

```yaml
volumes:
  - ./data/wordlists:/wordlists:ro
```

---

## 🌐 Network

All containers are on a shared Docker network for inter-container communication:

| Service | IP | Ports |
|---------|-----|-------|
| n01d-pentest | 172.28.0.10 | - |
| n01d-dev | 172.28.0.11 | 3000, 8000 |
| n01d-proxy | 172.28.0.20 | 8080, 8081 |
| n01d-vpn | 172.28.0.30 | 51820/udp |
| n01d-web | 172.28.0.40 | 80, 443 |
| n01d-db | 172.28.0.50 | 5432, 3306 |

---

## 🔧 Useful Commands

```bash
# Shell into a container
docker compose exec n01d-pentest bash

# View logs
docker compose logs -f n01d-proxy

# Rebuild a container
docker compose build n01d-dev

# Stop everything
docker compose down

# Remove all data
docker compose down -v
```

---

## 🔗 Part of the N01D Suite

| App | Description |
|-----|-------------|
| **[N01D-Docker](https://github.com/bad-antics/n01d-docker)** | Docker stack (you are here) |
| **[N01D-Term](https://github.com/bad-antics/n01d-term)** | Terminal emulator |
| **[N01D-Media](https://github.com/bad-antics/n01d-media)** | Media suite |
| **[Time Machine](https://github.com/bad-antics/n01d-timemachine)** | Classic computing |

---

<div align="center">

**[GitHub](https://github.com/bad-antics)** • **[NullSec](https://github.com/bad-antics/nullsec)** • **[Issues](https://github.com/bad-antics/n01d-docker/issues)**

*Containerized hacking. Portable power.*

**N01D Docker** — *Part of the NullSec Framework*

</div>
