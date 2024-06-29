#!/bin/bash

# Build nrf
docker build -t nrf:v3.1.1 -f Dockerfile .

# Build amf
docker build -t amf:v3.1.1b -f Dockerfile .

# Build smf
docker build -t smf:v3.1.1b -f Dockerfile .

# Build upfTer and upfMec
docker build -t upf:v3.1.1 -f Dockerfile .

# Build ausf
docker build -t ausf:v3.1.1 -f Dockerfile .

# Build nssf
docker build -t nssf:v3.1.1 -f Dockerfile .

# Build udm
docker build -t udm:v3.1.1 -f Dockerfile .

# Build udr
docker build -t udr:v3.1.1 -f Dockerfile .

# Build pcf
docker build -t pcf:v3.1.1 -f Dockerfile .

# Build Image 11
docker build -t uereg:latest -f Dockerfile .