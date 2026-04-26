FROM docker.n8n.io/n8nio/n8n:latest

USER root

RUN apk add --no-cache \
    ffmpeg \
    graphicsmagick \
    imagemagick \
    bash \
    curl \
    git

USER node