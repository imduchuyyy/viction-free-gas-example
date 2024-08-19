// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

abstract contract FeeGasReceiver {
    address private _proxy;
    
    function __FreeGas_init(address proxy) internal {
        _proxy = proxy;
    }

    function _caller() internal view virtual returns (address msgSender) {
        if (msg.sender == _proxy) {
            assembly { msgSender := shr(96, calldataload(sub(calldatasize(), 20))) }
        } else {
            return msg.sender;
        }
    }
}