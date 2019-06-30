FROM node:12-alpine

ENV HELM_VERSION v2.14.1
ENV KUBERNETES_VERSION v1.14.0

RUN apk add --update --no-cache ansible bash docker git vim curl gnupg make g++ wget htop openssh python2 shadow sudo

RUN npm install -g yarn@1.16.0 && \
  yarn global add @vue/cli@3.8.4

RUN usermod -aG wheel node && \
  sed --in-place 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+NOPASSWD:\s\+ALL\)/\1/' /etc/sudoers

RUN mkdir /.yarn-cache && \
  chown node:node /.yarn-cache && \
  printf "{\n\"useTaobaoRegistry\": false,\n\"packageManager\": \"yarn\"\n}" > /home/node/.vuerc  && \
  chown node:node /home/node/.vuerc && \
  wget https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz && \
  tar -zxvf helm-${HELM_VERSION}-linux-amd64.tar.gz && \
  mv linux-amd64/helm /usr/local/bin/helm && \
  mv linux-amd64/tiller /usr/local/bin/tiller && \
  rm -rf helm-${HELM_VERSION}-linux-amd64.tar.gz linux-amd64 && \
  curl -sSL -o /usr/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl" && \
  chmod +x /usr/bin/kubectl

USER node

RUN yarn config set cache-folder /.yarn-cache

WORKDIR /app

CMD ["yarn", "start"]