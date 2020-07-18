FROM node:7 AS base
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
WORKDIR /usr/src/app
COPY /src/server.js /usr/src/app

FROM node:7-alpine AS release
WORKDIR /usr/src/app
COPY --from=base /usr/src/app/package.json ./
RUN npm install --only=production && rm -rf node_modules
COPY --from=base /usr/src/app ./
EXPOSE 8080
ENTRYPOINT ["node", "server.js"]