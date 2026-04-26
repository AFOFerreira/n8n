FROM node:20-bookworm-slim

USER root

# Instalando dependências com limpeza imediata e sem recomendações desnecessárias
RUN apt-get update && apt-get install -y --no-install-recommends \
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

# Configuração para que o n8n reconheça o caminho do Chromium (importante para automações)
ENV CHROME_BIN=/usr/bin/chromium
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# Instalação do n8n com limpeza de cache
RUN npm install -g n8n@latest --omit=dev && npm cache clean --force

# Criar usuário de execução
RUN useradd -ms /bin/bash n8nuser
WORKDIR /home/n8nuser
USER n8nuser

EXPOSE 5678

CMD ["n8n", "start"]