FROM node:16-buster-slim

ENV HELM_VERSION v3.9.2
ENV KUBERNETES_VERSION v1.22.6

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \  
    ca-certificates \
    curl \ 
    git \ 
    gnupg \ 
    htop \
    openssh-client \
    python2 \
    python3 \
    jq \ 
    postgresql-client \
    sudo \ 
    vim \ 
    wget \
    zstd && \ 
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    echo "deb [arch=amd64] https://download.docker.com/linux/debian buster stable" | tee /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install --no-install-recommends -y docker-ce && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/*

RUN npm install -g --force yarn@1.22.10

RUN usermod -aG docker node

RUN wget https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz && \
  tar -zxvf helm-${HELM_VERSION}-linux-amd64.tar.gz && \
  mv linux-amd64/helm /usr/local/bin/helm && \
  rm -rf helm-${HELM_VERSION}-linux-amd64.tar.gz linux-amd64 && \
  curl -sSL -o /usr/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl" && \
  chmod +x /usr/bin/kubectl

USER node

WORKDIR /app

CMD ["yarn", "start"]
