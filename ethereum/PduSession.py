from web3 import Web3
import json

# Connect to local Ethereum node
ganache_url = "http://127.0.0.1:8545"
web3 = Web3(Web3.HTTPProvider(ganache_url))

# Check connection
if not web3.is_connected():
    raise Exception("Failed to connect to Ethereum node")

# Set the default account
web3.eth.default_account = web3.eth.accounts[0]

# Load the contract ABI and address
with open('/home/henok/ntn-5g-bl/ethereum/build/contracts/PduSessionManager.json') as f:
    contract_data = json.load(f)
abi = contract_data['abi']
contract_address = '0x2F0FA36227681dB8A07De53AD97AB3b9a69BF2c4'  # Replace with your contract address

# Get the contract instance
contract = web3.eth.contract(address=contract_address, abi=abi)

# Function to send transaction and wait for receipt
def send_transaction(transaction, private_key):
    signed_txn = web3.eth.account.sign_transaction(transaction, private_key=private_key)
    tx_hash = web3.eth.send_raw_transaction(signed_txn.raw_transaction)
    tx_receipt = web3.eth.wait_for_transaction_receipt(tx_hash)
    return tx_receipt

# Add session
def add_session(session_id):
    nonce = web3.eth.get_transaction_count(web3.eth.default_account)
    transaction = contract.functions.addSession(session_id).build_transaction({
        'chainId': 1337,  # Ganache's default chain ID
        'gas': 70000,
        'gasPrice': web3.to_wei('1', 'gwei'),
        'nonce': nonce,
    })
    private_key = '0xd43fd54c51396b251d4e0e5e603d156066f681997dc93f69ab7eb31d3e404af1'  # Replace with your private key
    tx_receipt = send_transaction(transaction, private_key)
    print(f"Transaction successful with hash: {tx_receipt.transactionHash.hex()}")

# Get session data
def get_session(session_id):
    try:
        session_data = contract.functions.getSession(session_id).call()
        print(f"Session Data: {session_data}")
    except Exception as e:
        print(f"Error retrieving session data: {e}")

# Main logic
session_id = 1
add_session(session_id)
get_session(session_id)
