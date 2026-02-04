<div align="center">

```
███╗   ██╗ ██████╗  ██╗██████╗     ██████╗  ██████╗  ██████╗██╗  ██╗███████╗██████╗ 
████╗  ██║██╔═══██╗███║██╔══██╗    ██╔══██╗██╔═══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗
██╔██╗ ██║██║   ██║╚██║██║  ██║    ██║  ██║██║   ██║██║     █████╔╝ █████╗  ██████╔╝
██║╚██╗██║██║   ██║ ██║██║  ██║    ██║  ██║██║   ██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗
██║ ╚████║╚██████╔╝ ██║██████╔╝    ██████╔╝╚██████╔╝╚██████╗██║  ██╗███████╗██║  ██║
╚═╝  ╚═══╝ ╚═════╝  ╚═╝╚═════╝     ╚═════╝  ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
                    [ SECURITY & DEV CONTAINERS | bad-antics ]
```

[![GitHub](https://img.shields.io/badge/GitHub-bad--antics-181717?style=for-the-badge&logo=github)](https://github.com/bad-antics)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://docker.com)
[![Containers](https://img.shields.io/badge/Containers-12-00D26A?style=for-the-badge)](containers/)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

**Pre-configured Docker containers for security research & development**

</div>

---

## 🐳 Containers

### Core Security
| Container | Description | Tools |
|-----------|-------------|-------|
| 🔴 **pentest** | Penetration testing | nmap, metasploit, burp, sqlmap, nikto |
| 🚩 **ctf** | CTF challenges | pwntools, gdb, radare2, ghidra, z3 |
| 🌐 **proxy** | Traffic interception | mitmproxy, burpsuite |
| 🔒 **vpn** | VPN gateway | OpenVPN, WireGuard |

### Specialized Security
| Container | Description | Tools |
|-----------|-------------|-------|
| 🔍 **osint** | OSINT & reconnaissance | shodan, theHarvester, sherlock, maigret |
| 👻 **stealth** | Network stealth | nullsec-ghost, macchanger, tor, proxychains |
| 📱 **mobile** | Mobile security (NullKia) | frida, objection, apktool, jadx |
| 🚗 **automotive** | Automotive (BlackFlag) | can-utils, python-can, udsoncan |

### Development & Tools
| Container | Description | Tools |
|-----------|-------------|-------|
| 💻 **dev** | Development environment | Python, Node, Go, Rust |
| �� **julia** | Julia data science | Julia, Pluto, security packages |
| 🔥 **forge** | Secure image burning | cryptsetup, ddrescue, n01d-forge |
| 🖥️ **machine** | VM management | qemu, libvirt, tor, n01d-machine |

---

## 🚀 Quick Start

```bash
# Clone the repo
git clone https://github.com/bad-antics/n01d-docker.git
cd n01d-docker

# Copy environment file
cp .env.example .env

# Build all containers
docker compose build

# Start specific container
docker compose up -d pentest
docker exec -it n01d-pentest /bin/bash
```

---

## 📦 Container Details

### 🔴 Pentest
Full Kali-based penetration testing environment.
```bash
docker compose up -d n01d-pentest
docker exec -it n01d-pentest /bin/bash
```

### 🔍 OSINT
Reconnaissance and open-source intelligence.
```bash
docker compose up -d n01d-osint
docker exec -it n01d-osint /bin/bash

# Run tools
theHarvester -d target.com -b all
sherlock username
```

### 📱 Mobile (NullKia)
Mobile application security testing.
```bash
docker compose up -d n01d-mobile
docker exec -it n01d-mobile /bin/bash

# Connect device and analyze
adb devices
frida-ps -U
objection -g com.app.target explore
```

### 🚗 Automotive (BlackFlag)
CAN bus and ECU security testing.
```bash
docker compose up -d n01d-automotive
docker exec -it n01d-automotive /bin/bash

# Setup virtual CAN
ip link add dev vcan0 type vcan
ip link set up vcan0

# Analyze traffic
candump vcan0
cansend vcan0 123#DEADBEEF
```

### 👻 Stealth
Network anonymization and spoofing.
```bash
docker compose up -d n01d-stealth
docker exec -it n01d-stealth /bin/bash

# MAC spoofing
macchanger -r eth0

# Route through Tor
proxychains4 curl ifconfig.me
```

### 🔥 Forge
Secure disk imaging with encryption.
```bash
docker compose up -d n01d-forge
docker exec -it n01d-forge /bin/bash

# Create encrypted image
cryptsetup luksFormat /dev/sdX
```

---

## 🌐 Network

All containers share a bridge network (`n01d-net`) with static IPs:

| Container | IP Address |
|-----------|------------|
| pentest | 172.28.0.10 |
| dev | 172.28.0.11 |
| julia | 172.28.0.12 |
| ctf | 172.28.0.13 |
| forge | 172.28.0.14 |
| machine | 172.28.0.15 |
| osint | 172.28.0.16 |
| mobile | 172.28.0.17 |
| automotive | 172.28.0.18 |
| stealth | 172.28.0.19 |
| proxy | 172.28.0.20 |
| vpn | 172.28.0.30 |

---

## 📁 Structure

```
n01d-docker/
├── docker-compose.yml
├── .env.example
├── containers/
│   ├── pentest/
│   ├── dev/
│   ├── julia/
│   ├── ctf/
│   ├── proxy/
│   ├── vpn/
│   ├── forge/
│   ├── machine/
│   ├── osint/
│   ├── mobile/
│   ├── automotive/
│   └── stealth/
├── data/           # Shared data volume
├── config/         # Tool configurations
└── vms/            # Virtual machine storage
```

---

## 🔧 Environment Variables

```bash
# .env
PROXY_PORT=8080
PROXY_WEB_PORT=8081
WG_PORT=51820
```

---

## 🛠️ Related Projects

| Project | Description |
|---------|-------------|
| [n01d-forge](https://github.com/bad-antics/n01d-forge) | Secure image burner |
| [n01d-machine](https://github.com/bad-antics/n01d-machine) | VM manager |
| [nullkia](https://github.com/bad-antics/nullkia) | Mobile security framework |
| [blackflag-ecu](https://github.com/bad-antics/blackflag-ecu) | Automotive testing |
| [nullsec-ghost](https://github.com/bad-antics/nullsec-ghost) | Network stealth |
| [nullsec-linux](https://github.com/bad-antics/nullsec-linux) | Security distro |

---

<div align="center">

**[bad-antics](https://github.com/bad-antics)** • For authorized security testing only

</div>
