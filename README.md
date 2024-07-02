# 5G NTNSecurity  with Blockchain

This code is intended for the work "Blockchain-Enhanced Security for LEO Satellite Firmware Updates in Beyond-5G NTN Networks"

## Build docker images for Free5GC core network:

Build core base image from directory: ./build/f5gc_core

In the directory: ./build/f5gc_core
     BUild the docker images with the tag defined in the docker-compose.yaml file. 

## Build satellite emulator : opensand
The satellite emulator containers will build upon runing the docker-compose.yaml file from directory: ./build/opensand

Three containers: Gateway, Satellite, and Terminal will be in runing state

## Build RAN image: UERANSIM

### Build base images from ./build/ueransim_base and bothe cmake and ueransim base images should be built

```
docker build -t cmake:v3.2 -f ./build/ueransim_base/cmake/Dockerfile
```
```
docker build -t ueransim:base -f ./build/ueransim_base/ueransim/Dockerfile
```

### Build gNB and UE from ./build/ueransim_ran

```
docker build -t gnb:master -f ./build/ueransim_ran/gnb/Dockerfile
```
```
docker build -t ue:master -f ./build/ueransim_ran/ue/Dockerfile
```


## Built Ganache local blockchain image

Build docker image for Ethereum local blockchain:

```
docker build -t trufflesuite/ganache-cli:latest -f ./ethereum/Dockerfile
```

## Built middleware image 

```
docker build -t ntn-5g-bl-middleware:latest -f ./middleware/DockerfileMiddleware
```

## The end-to-end blockchain based 5G NTN networks are shown below:

<img src="./Figs/network.png" title="./Figs/network.png" width=400px></img>

These fugures shows the overall build network for secure blockchain based 5G NTN network

<img src="./Figs/setup.png" title="./Figs/setup.png" width=500px></img>

# Start the network:

## Start Ganache CLI:  Ganache starts listening at port 8545

```
docker compose -f docker-compose-ganache.yml up
```

## Compile and deploy smart contract:

From the directory: ./ethereum

```
truffle compile
```

This will create the compiled ABI file including the bytecode in the directory: ./ethereum/build/contracts

```
truffle migrate --network development
```

This will deploy the compiled smart contract into the Ethereum Virtual Machine (EVM) and contract address is returned from the lockal blockchain

## Start Midleware: Listens at port 5000

Fetch the contract address and private key of the first ethereum account to which the contract is deployed

Sample account address and key pair:

```
0x001c62F91F80A5a0eeCc6F60B78F641911024257 : 0x5be3d9d215fc14b01f67630ff66faca9a15f27bcd5bf848f3cb4fbe95eddc7ef
```

```
docker compose -f docker-compose-middleware.yml up
```

## Deploy the 5G NTN network to interact with Ganache via the middleware

```
docker compose up
```

The satellite components are configured to interact to Ganache

Now an end-to-end GTP tunnel will be established if the traffic going to the satellite network is authenticated by the blockchain

Sample Ethereum addresses of servers: 0x7db8a5b543406b96390a0703ce2e28bc84eb6529

