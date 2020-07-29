const Shares = artifacts.require('./lib/Shares.sol');
const AdvertisementTracker = artifacts.require("AdvertisementTracker");
const AppCoins = artifacts.require("AppCoins");
const AppCoinsIAB = artifacts.require("AppCoinsIAB");

module.exports = function(deployer) {
  deployer.deploy(Shares);
  deployer.deploy(AdvertisementTracker);
  deployer.deploy(AppCoins);
  deployer.link(Shares, AppCoinsIAB);
  deployer.deploy(AppCoinsIAB);
};
