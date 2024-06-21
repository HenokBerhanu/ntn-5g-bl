import hashlib
# Hash the IP address to create a pseudo-Ethereum address or use a predefined mapping.
# Hashing function to convert IP addresses to Ethereum-like addresses
def ip_to_eth_address(ip_address):
    return '0x' + hashlib.sha256(ip_address.encode()).hexdigest()[:40]

# Example usage
gNB_address = ip_to_eth_address("192.168.35.3")  # For traffic passing through the gateway
gateway_address = ip_to_eth_address("172.20.0.3") # For traffic passing the satellite
satellite_address = ip_to_eth_address("172.20.0.2") # For traffic passing the terminal

print("gNB Address:", gNB_address)
print("gateway Address:", gateway_address)
print("satellite Address:", satellite_address)
