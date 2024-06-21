FROM node:14

WORKDIR /app

COPY package.json .
RUN npm install

COPY . .

CMD ["truffle", "migrate", "--network", "development"]
