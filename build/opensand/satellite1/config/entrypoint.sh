#!/bin/bash

service dbus start
service avahi-daemon start
opensand_interfaces

DEVICE_ADDRESS="0xd98f4441038010281073ce4e96a8c4fa1a2b1d96"

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
  ip route add 192.168.30.0/24 via 172.20.0.4
  ip route add 192.168.0.0/24 via 172.20.0.3
  ip route add 192.168.15.0/24 via 172.20.0.3
  sand-collector -b
  sand-daemon
  xvfb-run sand-manager -i
else
  echo "Device is not authorized. Traffic will not be forwarded."
  exit 1
fi

# service dbus start
# service avahi-daemon start
# opensand_interfaces
# ip route add 192.168.30.0/24 via 172.20.0.4
# ip route add 192.168.0.0/24 via 172.20.0.3
# ip route add 192.168.15.0/24 via 172.20.0.3
# sand-collector -b
# sand-daemon
# xvfb-run sand-manager -i
