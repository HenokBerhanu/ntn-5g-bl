#!/bin/bash

# Build gNBSat
docker build -t gnb:masterb -f DockerfileSat .

# Build gNBTer
docker build -t gnb:master -f DockerfileTer .

# Build UE
docker build -t ue:masterb -f Dockerfile .