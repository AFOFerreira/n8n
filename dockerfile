FROM node:20-alpine

ARG N8N_VERSION=latest

RUN apk add --no-cache \
    graphicsmagick \
    tzdata \
    git \
    tini \
    su-exec \
    ffmpeg \
    fontconfig \
    msttcorefonts-installer \
    python3 \
    make \
    g++ \
    ca-certificates

RUN update-ms-fonts && fc-cache -f

ENV PYTHON=/usr/bin/python3
ENV NODE_ICU_DATA=/usr/local/lib/node_modules/full-icu

RUN npm install -g full-icu n8n@${N8N_VERSION}

WORKDIR /data

EXPOSE 5678
CMD ["n8n"]