@echo off
REM ╔════════════════════════════════════════════════════════════════════════════════╗
REM ║                     N01D DOCKER — QUICK START (Windows)                       ║
REM ║                 Creates data dirs, copies .env, builds stack                  ║
REM ╚════════════════════════════════════════════════════════════════════════════════╝

echo.
echo  ███╗   ██╗ ██████╗  ██╗██████╗
echo  ████╗  ██║██╔═══██╗███║██╔══██╗
echo  ██╔██╗ ██║██║   ██║╚██║██║  ██║
echo  ██║╚██╗██║██║   ██║ ██║██║  ██║
echo  ██║ ╚████║╚██████╔╝ ██║██████╔╝
echo  ╚═╝  ╚═══╝ ╚═════╝  ╚═╝╚═════╝
echo  [N01D DOCKER STACK — SETUP]
echo.

REM Create data directories
echo [*] Creating data directories...
mkdir data\ollama 2>nul
mkdir data\open-webui 2>nul
mkdir data\agent-zero 2>nul
mkdir data\comfyui\storage 2>nul
mkdir data\comfyui\models 2>nul
mkdir data\comfyui\output 2>nul
mkdir data\musicgen\output 2>nul
mkdir data\musicgen\models 2>nul
mkdir config\mitmproxy 2>nul
mkdir config\wireguard 2>nul
echo [+] Done.

REM Copy .env if needed
if not exist .env (
    echo [*] Creating .env from .env.example...
    copy .env.example .env
    echo [+] Done. Edit .env to customize ports/models.
) else (
    echo [*] .env already exists, skipping.
)

echo.
echo [*] Building containers...
docker compose build

echo.
echo [*] Starting AI services...
docker compose up -d n01d-ollama n01d-webui n01d-agent-zero n01d-comfyui n01d-musicgen

echo.
echo [*] Waiting for Ollama to start...
timeout /t 10 /nobreak >nul

echo.
echo [*] Pulling AI models (this takes a while)...
docker exec n01d-ollama bash /scripts/pull-models.sh

echo.
echo ════════════════════════════════════════════════
echo  N01D STACK IS RUNNING!
echo.
echo  Open WebUI:   http://localhost:3080
echo  Agent Zero:   http://localhost:3100
echo  ComfyUI:      http://localhost:8188
echo  MusicGen:     http://localhost:7860
echo  Ollama API:   http://localhost:11434
echo.
echo  From other machines, replace localhost with
echo  this machine's IP address.
echo ════════════════════════════════════════════════
pause
