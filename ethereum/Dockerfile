FROM node:14
# docker build -t trufflesuite/ganache-cli:latest ./ethereum/Dockerfile
WORKDIR /app

COPY package.json .
RUN npm install

COPY . .

CMD ["truffle", "migrate", "--network", "development"]
