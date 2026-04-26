FROM n8nio/n8n:latest

ARG N8N_VERSION

RUN if [ -z "$N8N_VERSION" ] ; then echo "The N8N_VERSION argument is missing!" ; exit 1; fi

RUN apk add --update graphicsmagick tzdata git tini su-exec

USER root

RUN apk --update add --virtual build-dependencies python3 build-base ca-certificates && \
    npm config set python "$(which python3)" && \
    npm_config_user=root npm install -g full-icu n8n@${N8N_VERSION} && \
    apk del build-dependencies && \
    rm -rf /root /tmp/* /var/cache/apk/* && mkdir /root

RUN apk add --no-cache ffmpeg

RUN apk --no-cache add --virtual fonts msttcorefonts-installer fontconfig && \
    update-ms-fonts && \
    fc-cache -f && \
    apk del fonts && \
    find /usr/share/fonts/truetype/msttcorefonts/ -type l -exec unlink {} \; && \
    rm -rf /root /tmp/* /var/cache/apk/* && mkdir /root

ENV NODE_ICU_DATA=/usr/local/lib/node_modules/full-icu

WORKDIR /data

ENTRYPOINT ["tini", "--"]
CMD ["n8n"]

EXPOSE 5678