from flask import Flask, request, jsonify
from web3 import Web3
import json
import requests
import os
import logging

app = Flask(__name__)

# Enable logging
logging.basicConfig(level=logging.DEBUG)

# Connect to Ganache
ganache_url = os.getenv('GANACHE_URL', 'http://172.23.0.2:8545')
web3 = Web3(Web3.HTTPProvider(ganache_url))
web3.eth.default_account = web3.eth.accounts[0]

# Load contract ABI and address
contract_address = '0x055AB5DD98bdF7d668e675C585aF1d491a2a5D3A'
with open('/app/ethereum/build/contracts/TrafficControl.json') as f:
    contract_abi = json.load(f)['abi']
contract = web3.eth.contract(address=contract_address, abi=contract_abi)

@app.route('/authorize_device', methods=['POST'])
def authorize_device():
    try:
        data = request.get_json()
        logging.debug(f"Received data: {data}")
        device_address = data['device_address']
        
        # Convert to checksum address
        device_address = web3.to_checksum_address(device_address)
        
        nonce = web3.eth.get_transaction_count(web3.eth.default_account)
        transaction = contract.functions.authorizeDevice(device_address).build_transaction({
            'chainId': 1337,
            'gas': 70000,
            'gasPrice': web3.to_wei('1', 'gwei'),
            'nonce': nonce,
        })
        private_key = '0x6f07aa5da9acd0357741e95e83c73fc5569cb655451db3ff335ea8ebf051e8c5'
        signed_txn = web3.eth.account.sign_transaction(transaction, private_key=private_key)
        tx_hash = web3.eth.send_raw_transaction(signed_txn.rawTransaction)
        return jsonify({'tx_hash': tx_hash.hex()})
    except Exception as e:
        logging.error(f"Error authorizing device: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/deauthorize_device', methods=['POST'])
def deauthorize_device():
    try:
        data = request.get_json()
        logging.debug(f"Received data: {data}")
        device_address = data['device_address']
        
        # Convert to checksum address
        device_address = web3.to_checksum_address(device_address)
        
        nonce = web3.eth.get_transaction_count(web3.eth.default_account)
        transaction = contract.functions.deauthorizeDevice(device_address).build_transaction({
            'chainId': 1337,
            'gas': 70000,
            'gasPrice': web3.to_wei('1', 'gwei'),
            'nonce': nonce,
        })
        private_key = '0x6f07aa5da9acd0357741e95e83c73fc5569cb655451db3ff335ea8ebf051e8c5'
        signed_txn = web3.eth.account.sign_transaction(transaction, private_key=private_key)
        tx_hash = web3.eth.send_raw_transaction(signed_txn.rawTransaction)
        return jsonify({'tx_hash': tx_hash.hex()})
    except Exception as e:
        logging.error(f"Error deauthorizing device: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/is_authorized', methods=['GET'])
def is_authorized():
    try:
        device_address = request.args.get('device_address')
        logging.debug(f"Checking authorization for device: {device_address}")
        
        # Convert to checksum address
        device_address = web3.to_checksum_address(device_address)
        
        is_auth = contract.functions.isAuthorized(device_address).call()
        return jsonify({'is_authorized': is_auth})
    except Exception as e:
        logging.error(f"Error checking authorization: {e}")
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
