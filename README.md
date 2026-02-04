<div align="center">

```
███╗   ██╗ ██████╗  ██╗██████╗     ██████╗  ██████╗  ██████╗██╗  ██╗███████╗██████╗ 
████╗  ██║██╔═══██╗███║██╔══██╗    ██╔══██╗██╔═══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗
██╔██╗ ██║██║   ██║╚██║██║  ██║    ██║  ██║██║   ██║██║     █████╔╝ █████╗  ██████╔╝
██║╚██╗██║██║   ██║ ██║██║  ██║    ██║  ██║██║   ██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗
██║ ╚████║╚██████╔╝ ██║██████╔╝    ██████╔╝╚██████╔╝╚██████╗██║  ██╗███████╗██║  ██║
╚═╝  ╚═══╝ ╚═════╝  ╚═╝╚═════╝     ╚═════╝  ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
                    [ PENTEST & DEV CONTAINERS | bad-antics ]
```

[![GitHub](https://img.shields.io/badge/GitHub-bad--antics-181717?style=for-the-badge&logo=github)](https://github.com/bad-antics)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docker.com)
[![Containers](https://img.shields.io/badge/Containers-6-00D26A?style=for-the-badge)](containers/)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

**Pre-configured Docker containers for security research & development**

</div>

---

## 🐳 Containers

| Container | Description | Tools |
|-----------|-------------|-------|
| 🔴 **pentest** | Penetration testing | nmap, metasploit, burp, sqlmap |
| 💻 **dev** | Development environment | Python, Node, Go, Rust |
| 📊 **julia** | Julia data science | Julia, Pluto, security packages |
| 🚩 **ctf** | CTF challenges | pwntools, gdb, radare2, ghidra |
| 🌐 **proxy** | Traffic interception | mitmproxy, burpsuite |
| 🔒 **vpn** | VPN gateway | OpenVPN, WireGuard |

---

## 🚀 Quick Start

```bash
git clone https://github.com/bad-antics/n01d-docker.git
cd n01d-docker

# Build all containers
docker-compose build

# Start specific container
docker-compose up -d pentest
docker exec -it n01d-pentest /bin/bash

# Or use the launcher
./launch.sh pentest
```

---

## 📁 Structure

```
n01d-docker/
├── docker-compose.yml
├── containers/
│   ├── pentest/
│   ├── dev/
│   ├── julia/
│   ├── ctf/
│   ├── proxy/
│   └── vpn/
└── shared/          # Mounted to all containers
```

---

## ⚙️ Configuration

Each container has its own `Dockerfile` and config in `containers/`. Shared volumes mount to `/shared` inside containers.

---

<div align="center">

**[GitHub](https://github.com/bad-antics)** · **[NullSec](https://github.com/bad-antics/nullsec)**

</div>
