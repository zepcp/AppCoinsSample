# pip install web3==5.7.0
from json import loads

from web3 import Web3, HTTPProvider

web3 = Web3(HTTPProvider("http://127.0.0.1:8545", request_kwargs={"timeout": 60}))


def get_params(sender):
    return {"from": sender, "gasPrice": web3.eth.gasPrice, "gas": 6721975,
            "nonce": web3.eth.getTransactionCount(sender)}


# Ether Balances
print("\nEther Balances:\n{}\n{}".format(web3.eth.getBalance(web3.eth.accounts[0]),
                                         web3.eth.getBalance(web3.eth.accounts[1])))

# Ether Transfer
tx_params = {**get_params(web3.eth.accounts[0]), "to": web3.eth.accounts[1], "value": 1}
txid = Web3.toHex(web3.eth.sendTransaction(tx_params))
print("\nEther Transfer (Transaction):\n{}".format(web3.eth.getTransaction(txid)))

# Ether Balances
print("\nEther Balances:\n{}\n{}".format(web3.eth.getBalance(web3.eth.accounts[0]),
                                         web3.eth.getBalance(web3.eth.accounts[1])))

# Read Contract
with open("build/contracts/AppCoins.json", "r") as f_handler:
    contract_info = loads(f_handler.read())
    f_handler.close()

# Deploy Contract
initialize_contract = web3.eth.contract(abi=contract_info["abi"],
                                        bytecode=contract_info["bytecode"])
txid = initialize_contract.constructor().transact(get_params(web3.eth.accounts[0]))
receipt = web3.eth.waitForTransactionReceipt(txid)
appcoins_contract = web3.eth.contract(receipt.contractAddress, abi=contract_info["abi"])
print("\nAppCoins Contract Address:\n{}".format(receipt.contractAddress))

# AppCoins Balances
print("\nAppCoins Balances:\n{}\n{}".format(
    appcoins_contract.functions.balanceOf(web3.eth.accounts[0]).call(),
    appcoins_contract.functions.balanceOf(web3.eth.accounts[1]).call()))

# AppCoins Transfer
tx_params = appcoins_contract.functions.transfer(web3.eth.accounts[1], 1)\
    .buildTransaction(get_params(web3.eth.accounts[0]))
txid = Web3.toHex(web3.eth.sendTransaction(tx_params))
print("\nAppCoins Transfer (Transaction):\n{}".format(web3.eth.getTransaction(txid)))

receipt = web3.eth.getTransactionReceipt(txid)
print("\nAppCoins Transfer (Event):\n{}".format(
    appcoins_contract.events.Transfer().processReceipt(receipt)))

# AppCoins Balances
print("\nAppCoins Balances:\n{}\n{}".format(
    appcoins_contract.functions.balanceOf(web3.eth.accounts[0]).call(),
    appcoins_contract.functions.balanceOf(web3.eth.accounts[1]).call()))
