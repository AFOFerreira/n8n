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

RUN npm config set python "$(which python3)" && \
    npm install -g full-icu n8n@${N8N_VERSION}

ENV NODE_ICU_DATA=/usr/local/lib/node_modules/full-icu

WORKDIR /data

ENTRYPOINT ["tini", "--"]
CMD ["n8n"]

EXPOSE 5678