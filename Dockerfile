FROM node:20-alpine

WORKDIR /app

# Csak a package fajlokat masoljuk, hogy a cache mukodjon
COPY package*.json ./
RUN npm install

# App fajlok
COPY . .

EXPOSE 8080

CMD ["npm", "start"]
