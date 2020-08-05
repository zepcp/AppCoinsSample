/**
@title AppCoinsIAB Interface
@author App Store Foundation
@dev Base interface to implement In-app-billing functions.
*/
contract AppCoinsIABInterface {

    /**
    @notice Function to register a in-app-billing operation
    @dev
        Registers a in-app-billing operation with the needed information and transfers the correct
        amount from the user to the developer and remaining parties.
    @param _packageName Package name of the application from which the in-app-billing was generated
    @param _sku Item id for the item bought inside the specified application
    @param _amount Value (in wei) of AppCoins to be paid for the item
    @param _addr_appc Address of the AppCoins (ERC-20) contract to be used
    @param _dev Address of the application's developer
    @param _appstore Address of the appstore to receive part of the share
    @param _oem Address of the OEM to receive part of the share
    @param _countryCode Country code of the country from which the transaction was issued
    @return {"result" : "True if the transaction was successfull"}
    */
    function buy(
        string memory _packageName, string memory _sku, uint256 _amount, address _addr_appc, address _dev,
        address _appstore, address _oem, bytes2 _countryCode)
        public
        returns (bool result);
}
