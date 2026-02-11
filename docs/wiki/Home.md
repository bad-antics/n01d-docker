# N01D Docker Stack Wiki

Welcome to the **N01D Docker Stack** — custom security and development containers.

## Containers

| Container | Purpose | Base |
|-----------|---------|------|
| 🔓 Pentest | Full pentest toolkit | Kali Linux |
| 💻 Dev | Development environment | Ubuntu |
| 🔮 Julia | Julia security research | Julia official |
| 🏁 CTF | CTF competition tools | Debian |
| 🌐 Proxy | Traffic interception | Alpine |
| 🔒 VPN | WireGuard/OpenVPN | Alpine |

## Quick Start

```bash
git clone https://github.com/bad-antics/n01d-docker
cd n01d-docker

# Start pentest container
docker compose up -d pentest
docker exec -it n01d-pentest bash

# Start all containers
docker compose up -d
```
