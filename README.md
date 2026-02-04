<!--
SEO Keywords: Docker security, Docker pentest, hacking Docker, security Docker stack,
Kali Docker, pentesting Docker, CTF Docker, Docker development environment, bad-antics
-->

<div align="center">

```
╔═══════════════════════════════════════════════════════════════╗
║  🐳 N01D DOCKER  ·  Security & Development Container Stack    ║
╚═══════════════════════════════════════════════════════════════╝
```

[![GitHub](https://img.shields.io/badge/GitHub-bad--antics-181717?style=for-the-badge&logo=github)](https://github.com/bad-antics)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docker.com)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

**Containerized toolkit for security research, development, and hacking.**

</div>

---

## 🎯 Stack Overview

| Container | Purpose | Base |
|-----------|---------|------|
| `n01d-pentest` | Security testing | Kali Linux |
| `n01d-dev` | Development | Ubuntu 24.04 |
| `n01d-julia` | Julia research | Julia official |
| `n01d-ctf` | CTF challenges | Alpine |
| `n01d-proxy` | Traffic interception | mitmproxy |
| `n01d-vpn` | VPN tunneling | WireGuard |

---

## 🚀 Quick Start

```bash
git clone https://github.com/bad-antics/n01d-docker.git
cd n01d-docker

# Start full stack
docker compose up -d

# Or specific services
docker compose up -d n01d-pentest n01d-dev
```

---

## 📦 Containers

### 🔴 n01d-pentest
Kali-based pentesting environment.
```bash
docker compose run n01d-pentest
```
**Tools:** nmap, masscan, metasploit, sqlmap, gobuster, burp, aircrack-ng

### 💻 n01d-dev
Multi-language development.
```bash
docker compose run n01d-dev
```
**Languages:** Python 3.12, Node.js 22, Rust, Go 1.22, Julia 1.10

### 🔬 n01d-julia
Julia security research.
```bash
docker compose run n01d-julia
```

### 🏴 n01d-ctf
CTF environment with pwntools, gdb, binwalk.
```bash
docker compose run n01d-ctf
```

### 🔀 n01d-proxy
mitmproxy for interception.
```bash
docker compose up -d n01d-proxy
# Web UI: http://localhost:8081
```

---

## 🌐 Network

| Service | IP | Ports |
|---------|-----|-------|
| n01d-pentest | 172.28.0.10 | - |
| n01d-dev | 172.28.0.11 | 3000, 8000 |
| n01d-proxy | 172.28.0.20 | 8080, 8081 |
| n01d-vpn | 172.28.0.30 | 51820/udp |

---

## 🔧 Commands

```bash
docker compose exec n01d-pentest bash   # Shell into container
docker compose logs -f n01d-proxy       # View logs
docker compose build n01d-dev           # Rebuild
docker compose down                      # Stop all
```

---

## 🔗 Part of the N01D Suite

| App | Description |
|-----|-------------|
| **[N01D-Docker](https://github.com/bad-antics/n01d-docker)** | Container stack |
| **[N01D-Term](https://github.com/bad-antics/n01d-term)** | Terminal |
| **[Time Machine](https://github.com/bad-antics/n01d-timemachine)** | Classic computing |

---

<div align="center">

**[GitHub](https://github.com/bad-antics)** • **[NullSec](https://github.com/bad-antics/nullsec)**

*Containerized hacking. Portable power.*

</div>
