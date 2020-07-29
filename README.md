AppCoins Sample
======
**AppCoinsSample** is a sample example of the [AppStoreFoundation Smart-Contracts](https://github.com/AppStoreFoundation/asf-contracts)

Requirements
----------
    brew install node
    brew install npm
    npm install -g truffle
    npm install -g ganache-cli

* Due to an [ongoing bug](https://github.com/trufflesuite/ganache-cli/issues/732) on truffle node version should be <= 12.x.x

Launch a blockchain locally with [ganache-cli](https://github.com/trufflesuite/ganache-cli)
----------
    ganache-cli

Initialize project with [truffle](https://www.trufflesuite.com/docs)
----------
    truffle init

Compile
----------
    truffle compile

Deploy
----------
    truffle migrate

Run Tests
----------
    truffle test


Create Files
----------
    truffle create contract <name>
    truffle create test <name>
