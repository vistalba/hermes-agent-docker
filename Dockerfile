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
    && rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://bootstrap.pypa.io/get-pip.py | /opt/hermes/.venv/bin/python - \
    && /opt/hermes/.venv/bin/pip install --no-cache-dir \
    torch torchvision --index-url https://download.pytorch.org/whl/cpu \
    && /opt/hermes/.venv/bin/pip install --no-cache-dir \
    ddgs pymupdf marker-pdf pandas numpy matplotlib \
    yt-dlp beautifulsoup4 httpx

RUN chown -R hermes:hermes /opt/hermes/.venv

USER hermes
