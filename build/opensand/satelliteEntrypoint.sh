#!/bin/bash

# Start necessary services
service dbus start
service avahi-daemon start

# Middleware interaction for device authorization, the traffic pasing through the gateway will be authorized or deautorized.
DEVICE_ADDRESS="0xd98f4441038010281073ce4e96a8c4fa1a2b1d96"  # Update with the etherum address of the gateway 172.20.0.3

# Authorize the device
response=$(curl -s -X GET "http://localhost:5000/is_authorized?device_address=${DEVICE_ADDRESS}")
is_authorized=$(echo $response | jq -r '.is_authorized')

if [ "$is_authorized" == "true" ]; then
  echo "Device is authorized. Setting up routes and interfaces."

  # Configure interfaces and routes
  opensand_interfaces
  ip route add 192.168.30.0/24 via 172.20.0.4
  ip route add 192.168.0.0/24 via 172.20.0.3
  ip route add 192.168.15.0/24 via 172.20.0.3

  # Start sand services
  sand-collector -b
  sand-daemon
  xvfb-run sand-manager -i
else
  echo "Device is not authorized. Traffic will not be forwarded."
  exit 1
fi

# Keep the container running
exec "$@"