from node:carbon

workdir /usr/src/app

copy package*.json ./
run npm install

expose 8080

cmd ["npm", "start"]
