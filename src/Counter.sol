// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./FreeGasReceiver.sol";

contract Counter is FeeGasReceiver {
    address caller;

    constructor(address proxy) {
        __FreeGas_init(proxy);
    }

    function takePlace() external {
        caller = _caller();
    }
}
