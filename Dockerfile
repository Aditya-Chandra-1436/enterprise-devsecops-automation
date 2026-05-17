FROM node:20-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

HEALTHCHECK CMD wget --spider http://localhost:3000 || exit 1

USER node

CMD ["npm", "start"]
