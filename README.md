## 3D-NTN
This repo is intended for deploying blockchain-based satellite network security using Free5GC as a 5G core, OpenSand as a satellite emulator, and UERANSIM as a radio access emulator. All the components are deployed in a docker-compose environment as docker containers.

### Instructions

Clone repository in an environment where docker and docker-compose are pre-installed.

Build the docker images:

```
All the images are built and pushed to the docker hub
```
```
For OpenSand
cd /home/henok/ntn-5g-bl/build/opensand   # change with your directory
From this directory, all the components are built when running the docker-composeSat.yaml file.
```
```

### Before executing the network after building the images,
* Install GTP5G for the Free5GC UPF to enable the GPRS Tunnelling for a 5G-based network. Run the file **./installgtp5g.sh**
* Install Docker and docker-compose

### Run experiments
  
# The deployed network topology is shown below below:

docker compose -f docker-composeSat.yaml up

## Now we can exec into the user equipment and access the data network

## the figures in the Figs directory shows the screenshot of the end to end network with ping tests
