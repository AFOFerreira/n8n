FROM docker.n8n.io/n8nio/n8n:latest

USER root

RUN apt-get update && apt-get install -y \
    ffmpeg \
    graphicsmagick \
    imagemagick \
    bash \
    curl \
    git \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

USER node