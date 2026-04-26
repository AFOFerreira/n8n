FROM node:20-alpine

USER root

RUN apk add --no-cache \
    ffmpeg \
    graphicsmagick \
    imagemagick \
    bash \
    curl \
    git

RUN npm install -g n8n

RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node

USER node

CMD ["n8n"]