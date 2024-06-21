#!/bin/bash

# Start necessary services
service dbus start
service avahi-daemon start

# Middleware interaction for device authorization (control traffic coming from gNB 192.168.35.3)
DEVICE_ADDRESS="0x7db8a5b543406b96390a0703ce2e28bc84eb6529"  # Update with the ethereum address of gNB

# Authorize the device
response=$(curl -s -X GET "http://localhost:5000/is_authorized?device_address=${DEVICE_ADDRESS}")
is_authorized=$(echo $response | jq -r '.is_authorized')

if [ "$is_authorized" == "true" ]; then
  echo "Device is authorized. Setting up routes and interfaces."

  # Configure interfaces and routes
  opensand_interfaces
  iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
  ip route add 192.168.30.0/24 via 172.20.0.2  # Satellite1 route
  ip route add 192.168.0.0/24 via 192.168.35.3  # gNB route
  ip route add 192.168.15.0/24 via 192.168.35.3 # gNB route

  # Start sand-daemon service
  sand-daemon -f
else
  echo "Device is not authorized. Traffic will not be forwarded."
  exit 1
fi

# Keep the container running
exec "$@"