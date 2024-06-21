#!/bin/bash
#BIND_0=$1
ip route add 192.168.40.0/24 via 192.168.30.3 #$BIND_0
ip route add 192.168.0.0/24 via 192.168.30.3   # Add SBI
ip route add 192.168.15.0/24 via 192.168.30.3   # Add terrestrial route
ip route add 192.168.5.0/24 via 192.168.30.3

iperf -c 192.168.40.4 -B 192.168.30.3 -p 5060 --trip-times --tos 0xb8 -i 1 -u -l 1400 --reverse -t 240s -b 128k -f b > results/ue_voip.txt &
#iperf -c 172.16.3.4 -B $BIND_0 -p 8080 --trip-times --tos 0x28 -i 1 -u -l 1400 --reverse -t 240s -b 3M -f b > results/ue-0_web_0_probes.txt &

# sleep 6
# nr-ue --config uecfg.yaml
