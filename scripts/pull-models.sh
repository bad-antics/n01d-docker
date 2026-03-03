#!/bin/bash
#╔════════════════════════════════════════════════════════════════════════════════╗
#║                     N01D MODEL PULL SCRIPT                                     ║
#║    Pulls all pentest / uncensored / coding / utility models into Ollama       ║
#║    Usage: docker exec n01d-ollama /scripts/pull-models.sh                     ║
#╚════════════════════════════════════════════════════════════════════════════════╝

set -e

GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

pull_model() {
    local model="$1"
    local desc="$2"
    echo -e "${CYAN}[N01D]${NC} Pulling ${GREEN}${model}${NC} — ${desc}..."
    if ollama pull "$model"; then
        echo -e "${GREEN}  ✓ ${model} ready${NC}"
    else
        echo -e "${RED}  ✗ Failed to pull ${model}${NC}"
    fi
    echo ""
}

echo -e "${CYAN}"
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║              N01D AI LAB — MODEL INSTALLER                   ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# ═══════════════════════════════════════════════════════════════════════════════
# 🔓 UNCENSORED / FULLY UNLOCKED MODELS
# These models have NO alignment filters — use responsibly for security research
# ═══════════════════════════════════════════════════════════════════════════════
echo -e "${YELLOW}━━━ 🔓 UNCENSORED / UNLOCKED MODELS ━━━${NC}"
pull_model "dolphin-mistral:7b"        "Uncensored Mistral 7B (Eric Hartford's Dolphin — no alignment)"
pull_model "dolphin-llama3:8b"         "Uncensored Llama 3 8B (Dolphin — fully unlocked)"
pull_model "dolphin-mixtral:8x7b"      "Uncensored Mixtral MoE (Dolphin — most capable unlocked)"
pull_model "wizard-vicuna-uncensored:13b" "Wizard Vicuna 13B — classic uncensored model"
pull_model "llama2-uncensored:7b"      "Llama 2 Uncensored 7B — no guardrails"
pull_model "nous-hermes2:10.7b"        "Nous Hermes 2 Solar — powerful uncensored reasoning"

# ═══════════════════════════════════════════════════════════════════════════════
# 🔴 PENTESTING / SECURITY RESEARCH MODELS
# Optimized for offensive security, exploit dev, reverse engineering
# ═══════════════════════════════════════════════════════════════════════════════
echo -e "${YELLOW}━━━ 🔴 PENTESTING / SECURITY MODELS ━━━${NC}"
pull_model "dolphin-mistral:7b"        "Primary pentest assistant (uncensored + fast)"
pull_model "codellama:13b"             "Code Llama 13B — exploit dev, shellcode, RE"
pull_model "deepseek-coder-v2:16b"     "DeepSeek Coder v2 — advanced code analysis"
pull_model "phind-codellama:34b"       "Phind Code Llama 34B — best for complex exploits"

# ═══════════════════════════════════════════════════════════════════════════════
# 🧠 REASONING / GENERAL PURPOSE MODELS
# Shannon-class reasoning, Kimi-class intelligence
# ═══════════════════════════════════════════════════════════════════════════════
echo -e "${YELLOW}━━━ 🧠 REASONING & INTELLIGENCE MODELS ━━━${NC}"
pull_model "llama3.2:3b"               "Llama 3.2 3B — fast lightweight reasoning"
pull_model "llama3.1:8b"               "Llama 3.1 8B — balanced reasoning"
pull_model "qwen2.5:7b"                "Qwen 2.5 7B — strong multilingual reasoning"
pull_model "qwen2.5-coder:7b"          "Qwen 2.5 Coder 7B — code-focused reasoning"
pull_model "gemma2:9b"                 "Gemma 2 9B — Google's reasoning model"
pull_model "mistral:7b"                "Mistral 7B — efficient general purpose"
pull_model "deepseek-r1:8b"            "DeepSeek R1 8B — chain-of-thought reasoning (Shannon-class)"
pull_model "deepseek-r1:14b"           "DeepSeek R1 14B — deep reasoning (Kimi 2.5 equivalent)"
pull_model "command-r:35b"             "Cohere Command R 35B — advanced RAG + reasoning"

# ═══════════════════════════════════════════════════════════════════════════════
# 💻 CODING MODELS
# Best models for code generation, analysis, debugging
# ═══════════════════════════════════════════════════════════════════════════════
echo -e "${YELLOW}━━━ 💻 CODING MODELS ━━━${NC}"
pull_model "codellama:7b"              "Code Llama 7B — fast code generation"
pull_model "starcoder2:7b"             "StarCoder2 7B — multi-language code"
pull_model "codegemma:7b"              "CodeGemma 7B — Google's code model"

# ═══════════════════════════════════════════════════════════════════════════════
# 🔧 UTILITY MODELS (embeddings, function calling)
# Required by Agent Zero and Open WebUI features
# ═══════════════════════════════════════════════════════════════════════════════
echo -e "${YELLOW}━━━ 🔧 UTILITY MODELS ━━━${NC}"
pull_model "nomic-embed-text:latest"   "Text embeddings (used by Agent Zero + RAG)"
pull_model "all-minilm:latest"         "Fast embeddings for semantic search"

# ═══════════════════════════════════════════════════════════════════════════════
# SUMMARY
# ═══════════════════════════════════════════════════════════════════════════════
echo -e "${CYAN}"
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                    ALL MODELS PULLED ✓                       ║"
echo "║                                                              ║"
echo "║  Open WebUI:   http://<HOST_IP>:3080                        ║"
echo "║  Agent Zero:   http://<HOST_IP>:3100                        ║"
echo "║  Ollama API:   http://<HOST_IP>:11434                       ║"
echo "║                                                              ║"
echo "║  List models:  ollama list                                   ║"
echo "║  Quick test:   ollama run dolphin-mistral:7b                ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"
