FROM node:24-alpine3.20

WORKDIR /app

COPY server.js .
COPY package.json .

RUN ["npm", "init", "-y"]

RUN ["npm", "i"]

CMD [ "node", "server.js" ]