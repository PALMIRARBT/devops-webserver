FROM node:18-alpine

WORKDIR /usr/src/app

COPY src/ .

EXPOSE 8090

CMD [ "node", "index.js" ]