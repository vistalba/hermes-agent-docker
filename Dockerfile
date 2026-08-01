FROM nousresearch/hermes-agent:latest

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
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
    && rm -rf /var/lib/apt/lists/*

RUN /opt/hermes/.venv/bin/pip install --no-cache-dir \
    ddgs pymupdf marker-pdf playwright pandas numpy matplotlib \
    yt-dlp beautifulsoup4 httpx

RUN /opt/hermes/.venv/bin/playwright install chromium

RUN chown -R hermes:hermes /opt/hermes/.venv

USER hermes
