#!/bin/bash

# Build gNBSat
docker build -t gnb:master -f DockerfileSat .

# # Build gNBTer
# docker build -t gnb:master -f DockerfileTer .

# Build UE
docker build -t ue:master -f Dockerfile .