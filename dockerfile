FROM node:20-bookworm

USER root

RUN apt-get update && apt-get install -y \
    ffmpeg \
    graphicsmagick \
    imagemagick \
    chromium \
    curl \
    git \
    python3 \
    python3-pip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN npm install -g n8n

RUN useradd -ms /bin/bash nodeuser

USER nodeuser

EXPOSE 5678

CMD ["n8n"]