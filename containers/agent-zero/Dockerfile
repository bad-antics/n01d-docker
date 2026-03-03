#╔════════════════════════════════════════════════════════════════════════════════╗
#║                        AGENT ZERO CONTAINER                                    ║
#║          Autonomous AI Agent Framework — tool use, code exec, browsing        ║
#╚════════════════════════════════════════════════════════════════════════════════╝

FROM python:3.11-slim

LABEL maintainer="bad-antics"
LABEL description="Agent Zero - Autonomous AI agent with tool use and code execution"

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV PIP_NO_CACHE_DIR=1

# Install system deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl wget build-essential \
    chromium chromium-driver \
    libxml2-dev libxslt1-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install CPU-only PyTorch FIRST to prevent CUDA bloat
RUN pip install --upgrade pip && \
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# Clone Agent Zero and install its requirements
RUN git clone https://github.com/frdel/agent-zero.git . && \
    pip install -r requirements.txt 2>/dev/null || true

# Install additional tools (torch already satisfied from CPU build above)
RUN pip install \
    requests beautifulsoup4 lxml \
    python-whois dnspython \
    paramiko pexpect \
    selenium webdriver-manager \
    flask gradio \
    openai ollama \
    chromadb sentence-transformers \
    2>/dev/null || true

# Create work directory
RUN mkdir -p /app/work_dir

EXPOSE 80

# Start Agent Zero web UI
CMD ["python", "run_ui.py"]
