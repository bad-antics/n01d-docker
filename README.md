# N01D Docker

```
 ███╗   ██╗ ██████╗  ██╗██████╗     ██████╗  ██████╗  ██████╗██╗  ██╗███████╗██████╗ 
 ████╗  ██║██╔═══██╗███║██╔══██╗    ██╔══██╗██╔═══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗
 ██╔██╗ ██║██║   ██║╚██║██║  ██║    ██║  ██║██║   ██║██║     █████╔╝ █████╗  ██████╔╝
 ██║╚██╗██║██║   ██║ ██║██║  ██║    ██║  ██║██║   ██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗
 ██║ ╚████║╚██████╔╝ ██║██████╔╝    ██████╔╝╚██████╔╝╚██████╗██║  ██╗███████╗██║  ██║
 ╚═╝  ╚═══╝ ╚═════╝  ╚═╝╚═════╝     ╚═════╝  ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
                    [ PENTEST & DEV CONTAINERS | bad-antics ]
                              v2.0 — AI · Music · Art
```

Pre-configured Docker containers for security research, AI/ML, image generation, music creation, and development.

---

## Containers

### AI / LLM Services

- **ollama** (port 11434) — Local LLM engine, runs all text models
- **webui / Open WebUI** (port 3080) — ChatGPT-style web interface for all models
- **agent-zero** (port 3100) — Autonomous AI agent with tool use + code execution

### Creative / Generative

- **comfyui** (port 8188) — Image/logo/art generation (Stable Diffusion, SDXL, Flux)
- **musicgen** (port 7860) — AI music generation (Meta AudioCraft)

### Security / Pentest

- **pentest** — Kali Linux with nmap, metasploit, burp, sqlmap
- **ctf** — CTF tools with pwntools, gdb, radare2, ghidra
- **proxy** (port 8080/8081) — mitmproxy traffic interception
- **vpn** (port 51820/udp) — WireGuard VPN gateway

### Development

- **dev** (port 3000/8000) — Python, Node, Go, Rust dev environment
- **julia** — Julia data science + security research

---

## AI Models Included

After starting Ollama, run the model pull script to download everything:

```bash
docker exec n01d-ollama bash /scripts/pull-models.sh
```

### Uncensored / Fully Unlocked

- **dolphin-mistral:7b** (4.1 GB) — Eric Hartford's Dolphin, no alignment filters
- **dolphin-llama3:8b** (4.7 GB) — Dolphin Llama 3, fully unlocked
- **dolphin-mixtral:8x7b** (26 GB) — Most capable uncensored MoE model
- **wizard-vicuna-uncensored:13b** (7.4 GB) — Classic uncensored model
- **llama2-uncensored:7b** (3.8 GB) — No guardrails Llama 2
- **nous-hermes2:10.7b** (6.1 GB) — Powerful uncensored reasoning

### Pentesting / Security

- **codellama:13b** (7.4 GB) — Exploit dev, shellcode, reverse engineering
- **deepseek-coder-v2:16b** (8.9 GB) — Advanced code/vuln analysis
- **phind-codellama:34b** (19 GB) — Complex exploit generation

### Reasoning

- **deepseek-r1:8b** (4.9 GB) — Chain-of-thought reasoning
- **deepseek-r1:14b** (9.0 GB) — Deep reasoning
- **qwen2.5:7b** (4.7 GB) — Strong multilingual reasoning
- **command-r:35b** (20 GB) — Advanced RAG + reasoning

### Code Generation

- **codellama:7b** (3.8 GB) — Fast code generation
- **starcoder2:7b** (4.0 GB) — Multi-language code
- **codegemma:7b** (5.0 GB) — Google's code model
- **qwen2.5-coder:7b** (4.7 GB) — Qwen code specialist

### Utility

- **nomic-embed-text** (274 MB) — Embeddings for Agent Zero + RAG
- **all-minilm** (45 MB) — Fast semantic search

---

## Quick Start

```bash
cd n01d-docker

# Copy environment config
cp .env.example .env

# Build all containers
docker compose build

# Start everything (or pick what you need)
docker compose up -d

# Pull all AI models (takes a while on first run)
docker exec n01d-ollama bash /scripts/pull-models.sh

# Open your browser
#   Open WebUI  -> http://localhost:3080
#   ComfyUI     -> http://localhost:8188
#   MusicGen    -> http://localhost:7860
#   Agent Zero  -> http://localhost:3100
```

### Start Individual Service Groups

```bash
# AI only
docker compose up -d n01d-ollama n01d-webui n01d-agent-zero

# Creative only
docker compose up -d n01d-comfyui n01d-musicgen

# Pentest only
docker compose up -d n01d-pentest n01d-proxy n01d-vpn

# Shell into pentest container
docker exec -it n01d-pentest /bin/bash
```

---

## Accessing From Other Machines on Your Network

Every service binds to `0.0.0.0` so it is accessible on your LAN.

### Step 1 — Find Your Host Machine IP

```powershell
ipconfig | Select-String "IPv4"
# Look for something like 192.168.1.100 or 10.0.0.50
```

### Step 2 — Access Services from Any Device

Replace `HOST_IP` with the IP you found above. From any computer, phone, or tablet on the same network:

- **Open WebUI** — `http://HOST_IP:3080` — Chat with any AI model
- **Agent Zero** — `http://HOST_IP:3100` — Autonomous AI agent
- **ComfyUI** — `http://HOST_IP:8188` — Generate images, logos, art
- **MusicGen** — `http://HOST_IP:7860` — Generate music from text
- **Ollama API** — `http://HOST_IP:11434` — Raw LLM API endpoint
- **mitmproxy** — `http://HOST_IP:8081` — Web traffic inspection UI

### Step 3 — Windows Firewall Rules (if needed)

```powershell
# Run as Administrator — opens all N01D ports
$ports = @(3080, 3100, 7860, 8080, 8081, 8188, 11434, 51820)
foreach ($port in $ports) {
    New-NetFirewallRule -DisplayName "N01D Docker - Port $port" `
        -Direction Inbound -Protocol TCP -LocalPort $port `
        -Action Allow -Profile Private
}
# UDP for WireGuard
New-NetFirewallRule -DisplayName "N01D Docker - WireGuard UDP" `
    -Direction Inbound -Protocol UDP -LocalPort 51820 `
    -Action Allow -Profile Private

Write-Host "All N01D ports opened in Windows Firewall"
```

### Step 4 — Using Ollama from Remote Apps

Any app that supports Ollama (like other Open WebUI instances, Continue.dev, etc.) can point to your server:

```
Ollama URL: http://HOST_IP:11434
```

---

## Structure

```
n01d-docker/
  docker-compose.yml          — All services defined here
  .env.example                — Configuration template
  scripts/
    pull-models.sh            — Downloads all Ollama models
  containers/
    pentest/                  — Kali security tools
    dev/                      — Multi-language dev env
    julia/                    — Julia data science
    ctf/                      — CTF challenge tools
    proxy/                    — mitmproxy
    vpn/                      — WireGuard
    agent-zero/               — Autonomous AI agent
    musicgen/                 — AI music generation
  config/
    mitmproxy/
    wireguard/
  data/                       — Persistent data
    ollama/                   — Downloaded models
    open-webui/               — Chat history
    agent-zero/               — Agent workdir
    comfyui/                  — SD models + outputs
    musicgen/                 — Generated music
```

---

## Configuration

Copy `.env.example` to `.env` and customize ports, models, etc. Each container has its own Dockerfile in `containers/`. All persistent data lives in `data/`.

### GPU Support

If you have an NVIDIA GPU with enough VRAM, uncomment the `deploy` sections in `docker-compose.yml` for:

- **Ollama** — runs LLMs on GPU (much faster inference)
- **ComfyUI** — runs Stable Diffusion on GPU (required for decent speed)
- **MusicGen** — runs AudioCraft on GPU (faster generation)

You will also need NVIDIA Container Toolkit installed: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html

---

## Useful Commands

```bash
# Check what is running
docker compose ps

# View logs
docker compose logs -f n01d-ollama
docker compose logs -f n01d-webui

# List downloaded models
docker exec n01d-ollama ollama list

# Quick-test a model
docker exec -it n01d-ollama ollama run dolphin-mistral:7b

# Pull a single model
docker exec n01d-ollama ollama pull deepseek-r1:14b

# Stop everything
docker compose down

# Stop + remove volumes (clean slate)
docker compose down -v
```

---

GitHub: https://github.com/bad-antics
NullSec: https://github.com/bad-antics/nullsec

Made by bad-antics — https://github.com/bad-antics
