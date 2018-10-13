FROM node:10-alpine

RUN apk add --update --no-cache ansible bash docker git vim curl gnupg make g++ wget htop openssh python2 shadow sudo

RUN npm install -g yarn@1.10.1 && \
  yarn global add @vue/cli@3.0.5

RUN mkdir /.yarn-cache && \
  chown node:node /.yarn-cache && \
  printf "{\n\"useTaobaoRegistry\": false,\n\"packageManager\": \"yarn\"\n}" > /home/node/.vuerc  && \
  chown node:node /home/node/.vuerc

RUN usermod -aG wheel node && \
  sed --in-place 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+NOPASSWD:\s\+ALL\)/\1/' /etc/sudoers

USER node

RUN yarn config set cache-folder /.yarn-cache

WORKDIR /app

CMD ["yarn", "start"]