pragma solidity >=0.4.25 <0.7.0;

import { Shares } from "./lib/Shares.sol";
import { AppCoinsIABInterface } from "./lib/AppCoinsIABInterface.sol";
import { AppCoins } from "./AppCoins.sol";


contract AppCoinsIAB is AppCoinsIABInterface {

    event Buy(string packageName, string _sku, uint _amount, address _from, address _dev, address _appstore, address _oem, bytes2 countryCode);
    event OffChainBuy(address _wallet, bytes32 _rootHash);

    /**
    @notice Emits an event informing offchain transactions for in-app-billing
    @dev
        For each wallet passed as argument, the specified roothash is emited in a OffChainBuy event.

    @param _walletList List of wallets for which a OffChainBuy event will be issued
    @param _rootHashList List of roothashs for given transactions
    */
    function informOffChainBuy(address[] memory _walletList, bytes32[] memory _rootHashList)
        public
    {
        require(_walletList.length == _rootHashList.length);
        for(uint i = 0; i < _walletList.length; i++){
            emit OffChainBuy(_walletList[i],_rootHashList[i]);
        }
    }

    function buy(string memory _packageName, string memory _sku, uint256 _amount, address _addr_appc, address _dev, address _appstore, address _oem, bytes2 _countryCode) public returns (bool) {
        require(_addr_appc != address(0));
        require(_dev != address(0));
        require(_appstore != address(0));
        require(_oem != address(0));

        AppCoins appc = AppCoins(_addr_appc);
        require(appc.allowance(msg.sender, address(this)) >= _amount);

        uint[] memory amounts = new uint[](3);
        amounts[0] = _amount * Shares.getDevShare() / 100;
        amounts[1] = _amount * Shares.getAppStoreShare() / 100;
        amounts[2] = _amount * Shares.getOEMShare() / 100;

        uint remaining = _amount - (amounts[0] + amounts[1] + amounts[2]);

        appc.transferFrom(msg.sender, _dev, amounts[0] + remaining);
        appc.transferFrom(msg.sender, _appstore, amounts[1]);
        appc.transferFrom(msg.sender, _oem, amounts[2]);

        emit Buy(_packageName, _sku, _amount, msg.sender, _dev, _appstore, _oem, _countryCode);

        return true;
    }
}
