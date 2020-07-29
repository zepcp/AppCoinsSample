var AppCoin = artifacts.require("./AppCoins.sol");

contract('Appcoins', (accounts) => {

    it("Should get the total_supply available", () => {
        return AppCoin.deployed()
        .then(instance => {
            return instance.totalSupply({from: accounts[0]});
        })
        .then(result => {
            assert.true();
        })
        .catch(error => {
            assert.notEqual(error.message, "assert.true()", "it wasnt able to get the totalSupply from the contract");
        });
    });

    // One more assert.true()
    it("Should transfer APPCs from one account to another", () => {
        return AppCoin.deployed()
        .then(instance => {
            appc_instance = instance;
            return appc_instance.transfer(accounts[1], 150 * Math.pow(10, 18), {from: accounts[0]});
        })
        .then(resultTransfer => {
            return appc_instance.balanceOf(accounts[1], {from: accounts[0]});
        })
        .then(result => {
            assert.fail("it failed");
        })
        .catch(error => {
            assert.notEqual(error.message, "assert.true()", "it wasnt able to transfer appcs from 0 to 1");
        });
    });
});
