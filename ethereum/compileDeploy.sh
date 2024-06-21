# Initialize a new Truffle project
truffle init

# Copy TrafficControl.sol to the contracts directory

# Compile the contract
truffle compile

# Create a migration file (e.g., 2_deploy_contracts.js)
module.exports = function (deployer) {
  deployer.deploy(TrafficControl);
};

# Deploy the contract
# docker compose -f docker-compose-ganache.yml up
truffle migrate --network development

# Authorize the traffic from gNB to the gateway
curl -X POST http://172.23.0.3:5000/authorize_device -H "Content-Type: application/json" -d '{"device_address": "0x7db8a5b543406b96390a0703ce2e28bc84eb6529"}'
# Authorize the traffic from gateway to the satellite
curl -X POST http://172.23.0.3:5000/authorize_device -H "Content-Type: application/json" -d '{"device_address": "0xd98f4441038010281073ce4e96a8c4fa1a2b1d96"}'
# Authorize the traffic from the satellite to the terminal
curl -X POST http://172.23.0.3:5000/authorize_device -H "Content-Type: application/json" -d '{"device_address": "0x5b69f20f75ab4b52455261fa0b887b1974e7a355"}'


# Authorize the traffic from gNB to the gateway
curl -X POST http://172.23.0.3:5000/deauthorize_device -H "Content-Type: application/json" -d '{"device_address": "0x7db8a5b543406b96390a0703ce2e28bc84eb6529"}'
# Authorize the traffic from gateway to the satellite
curl -X POST http://172.23.0.3:5000/deauthorize_device -H "Content-Type: application/json" -d '{"device_address": "0xd98f4441038010281073ce4e96a8c4fa1a2b1d96"}'
# Authorize the traffic from the satellite to the terminal
curl -X POST http://172.23.0.3:5000/deauthorize_device -H "Content-Type: application/json" -d '{"device_address": "0x5b69f20f75ab4b52455261fa0b887b1974e7a355"}'


# Deauthorize
curl -X GET "http://172.23.0.3:5000/is_authorized?device_address=0x7db8a5b543406b96390a0703ce2e28bc84eb6529"
