#!/bin/bash

service dbus start
service avahi-daemon start
opensand_interfaces

DEVICE_ADDRESS="0x5b69f20f75ab4b52455261fa0b887b1974e7a355"

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
  ip route add 192.168.0.0/24 via 172.20.0.2
  ip route add 192.168.15.0/24 via 172.20.0.2
  sand-daemon -f
else
  echo "Device is not authorized. Traffic will not be forwarded."
  exit 1
fi

# service dbus start
# service avahi-daemon start
# opensand_interfaces
# ip route add 192.168.0.0/24 via 172.20.0.2
# ip route add 192.168.15.0/24 via 172.20.0.2
# sand-daemon -f
