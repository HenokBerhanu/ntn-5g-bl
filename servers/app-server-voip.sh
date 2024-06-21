#!/bin/bash

iperf -s -B 192.168.40.4 -p 5060 -u -l 1400 -i 1 -f b --tos 0xb8 > results/app-server-voip.txt