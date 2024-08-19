// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract FeeGasProxy {
    // The order of _balances, _minFee, _issuer must not be changed to pass validation of VictionZ application
    mapping(address => uint256) private _balances;
    uint256 private _minFee;
    address private _owner;

    constructor(address owner) {
        _owner = owner;
    }

    /**
     * @notice For Apply VictionZ
     */
    function issuer() public view returns (address) {
        return _owner;
    }

    /**
     * @notice For Apply VictionZ
     */
    function minFee() public view returns (uint256) {
        return _minFee;
    }

    /**
     * @notice For Apply VictionZ
     */
    function balanceOf(address user) public view returns (uint256) {
        return _balances[user];
    }


    function call(address target, bytes memory data) external payable {
        bytes memory callData = abi.encodePacked(data, msg.sender);
        (bool success, ) = target.call{value: msg.value}(callData);
        require(success, "Proxy: external call failed");
    }

    function multiCall(address[] memory targets, uint256[] memory values, bytes[] memory data) external payable {
        require(targets.length == data.length, "Proxy: invalid input");
        for (uint256 i = 0; i < targets.length; i++) {
            bytes memory callData = abi.encodePacked(data[i], msg.sender);
            (bool success, ) = targets[i].call{value: values[i]}(callData);
            require(success, "Proxy: external call failed");
        }
    }
}