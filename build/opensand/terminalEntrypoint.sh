#!/bin/bash

# Start necessary services
service dbus start
service avahi-daemon start

# Middleware interaction for device authorization, the ethereum address of satellite 172.20.0.2
DEVICE_ADDRESS="0x5b69f20f75ab4b52455261fa0b887b1974e7a355"  # Update with the address of the satellite

# Authorize the device
response=$(curl -s -X GET "http://localhost:5000/is_authorized?device_address=${DEVICE_ADDRESS}")
is_authorized=$(echo $response | jq -r '.is_authorized')

if [ "$is_authorized" == "true" ]; then
  echo "Device is authorized. Setting up routes and interfaces."

  # Configure interfaces and routes
  opensand_interfaces
  ip route add 192.168.0.0/24 via 172.20.0.2  # Add sbi
  ip route add 192.168.15.0/24 via 172.20.0.2  # Add terrestrial route

  # Start sand-daemon service
  sand-daemon -f
else
  echo "Device is not authorized. Traffic will not be forwarded."
  exit 1
fi

# Keep the container running
exec "$@"
