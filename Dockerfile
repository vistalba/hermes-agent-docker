FROM nousresearch/hermes-agent:latest

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    ffmpeg \
    libomp5 \
    tesseract-ocr \
    tesseract-ocr-deu \
    tesseract-ocr-fra \
    fonts-noto-core \
    fonts-liberation \
    # Playwright-Chromium braucht diese Libs:
    libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 \
    libdrm2 libxkbcommon0 libxcomposite1 libxdamage1 \
    libxrandr2 libgbm1 libasound2 libpango-1.0-0 \
    libcairo2 libxshmfence1 \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://bootstrap.pypa.io/get-pip.py | /opt/hermes/.venv/bin/python - \
    && /opt/hermes/.venv/bin/pip install --no-cache-dir \
    ddgs pymupdf marker-pdf playwright pandas numpy matplotlib \
    yt-dlp beautifulsoup4 httpx

RUN /opt/hermes/.venv/bin/playwright install chromium

RUN chown -R hermes:hermes /opt/hermes/.venv

USER hermes
