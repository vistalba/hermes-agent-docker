FROM nousresearch/hermes-agent:latest

USER root

# Install essential system dependencies and headless browser tools
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    git \
    ffmpeg \
    chromium \
    chromium-driver \
    libomp5 \
    tesseract-ocr \
    tesseract-ocr-deu \
    tesseract-ocr-fra \
    fonts-noto-core \
    fonts-liberation \
    && chown -R hermes:hermes /opt/hermes/.venv/ \
    && rm -rf /var/lib/apt/lists/*

# Install high-utility Python packages directly into Hermes venv
RUN su hermes -c "/opt/hermes/.venv/bin/python -m uv pip install \
    ddgs pymupdf marker-pdf playwright pandas numpy matplotlib \
    yt-dlp beautifulsoup4 httpx"

# Initialize Playwright browser binaries for the hermes user
# RUN su hermes -c "/opt/hermes/.venv/bin/playwright install chromium"

USER hermes
