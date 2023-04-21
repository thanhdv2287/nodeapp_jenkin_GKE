FROM node:latest

WORKDIR /usr/src/app

COPY package.json ./
COPY index.js ./

RUN npm install

COPY . .

EXPOSE 4000
CMD [ "node", "index.js" ]
