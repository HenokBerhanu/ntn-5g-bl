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

docker build -t cmake:v3.2 -f ./build/ueransim_base/cmake/Dockerfile

docker build -t ueransim:base -f ./build/ueransim_base/ueransim/Dockerfile

### Build gNB and UE from ./build/ueransim_ran

docker build -t gnb:master -f ./build/ueransim_ran/gnb/Dockerfile

docker build -t ue:master -f ./build/ueransim_ran/ue/Dockerfile


## Built Ganache local blockchain image

Build docker image for Ethereum local blockchain:

docker build -t trufflesuite/ganache-cli:latest ./ethereum/Dockerfile



## Built middleware image 

