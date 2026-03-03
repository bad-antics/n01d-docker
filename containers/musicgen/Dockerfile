#╔════════════════════════════════════════════════════════════════════════════════╗
#║                        MUSICGEN CONTAINER                                      ║
#║          Meta's AudioCraft MusicGen — Text-to-Music AI Generator              ║
#╚════════════════════════════════════════════════════════════════════════════════╝

FROM python:3.10-slim

LABEL maintainer="bad-antics"
LABEL description="MusicGen - AI music generation via Meta AudioCraft with Gradio UI"

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV GRADIO_SERVER_NAME=0.0.0.0
ENV GRADIO_SERVER_PORT=7860

# Install system deps (ffmpeg for audio processing + PyAV build deps)
RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl wget ffmpeg libsndfile1 \
    build-essential pkg-config \
    libavformat-dev libavcodec-dev libavutil-dev libswresample-dev libavdevice-dev libavfilter-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install PyTorch (CPU — uncomment the GPU line if you have NVIDIA)
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir torch torchaudio --index-url https://download.pytorch.org/whl/cpu
# For GPU: pip install --no-cache-dir torch torchaudio --index-url https://download.pytorch.org/whl/cu121

# Install av (PyAV) first — audiocraft needs it
RUN pip install --no-cache-dir av

# Install AudioCraft (MusicGen) + Gradio UI
RUN pip install --no-cache-dir \
    audiocraft \
    gradio \
    scipy \
    soundfile

# Create the Gradio app
COPY app.py /app/app.py

# Create output directory
RUN mkdir -p /app/output /app/models

EXPOSE 7860

CMD ["python", "app.py"]
