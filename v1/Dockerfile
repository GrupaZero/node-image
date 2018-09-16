FROM node:10-alpine

RUN apk add --update --no-cache bash git vim curl gnupg make g++ wget htop python

RUN npm install -g yarn@1.9.4 && \
  yarn global add @vue/cli@3.0.3

RUN mkdir /.yarn-cache && \
  chown node:node /.yarn-cache && \
  printf "{\n\"useTaobaoRegistry\": false,\n\"packageManager\": \"yarn\"\n}" > /home/node/.vuerc  && \
  chown node:node /home/node/.vuerc

USER node

RUN yarn config set cache-folder /.yarn-cache

WORKDIR /app

CMD ["yarn", "start"]