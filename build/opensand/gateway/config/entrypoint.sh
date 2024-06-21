#!/bin/bash

service dbus start
service avahi-daemon start
opensand_interfaces
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

DEVICE_ADDRESS="0x7db8a5b543406b96390a0703ce2e28bc84eb6529"

# Authorization check
echo "Checking authorization for device: $DEVICE_ADDRESS"
curl -v -o response.json -w "%{http_code}" "http://172.23.0.3:5000/is_authorized?device_address=$DEVICE_ADDRESS"
status_code=$(tail -n1 response.json)

if [ "$status_code" -ne 200 ]; then
  echo "Curl command failed with HTTP status code: $status_code"
  cat response.json
  exit 1
fi

is_authorized=$(jq -r '.is_authorized' response.json)
if [ "$is_authorized" == "true" ]; then
  echo "Device is authorized. Traffic will be forwarded."
  ip route add 192.168.30.0/24 via 172.20.0.2
  ip route add 192.168.0.0/24 via 192.168.35.3
  ip route add 192.168.15.0/24 via 192.168.35.3
  sand-daemon -f
else
  echo "Device is not authorized. Traffic will not be forwarded."
  exit 1
fi

# service dbus start
# service avahi-daemon start
# opensand_interfaces
# iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
# ip route add 192.168.30.0/24 via 172.20.0.2
# ip route add 192.168.0.0/24 via 192.168.35.3
# ip route add 192.168.15.0/24 via 192.168.35.3
# sand-daemon -f

