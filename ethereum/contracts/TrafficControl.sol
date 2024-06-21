// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TrafficControl {
    mapping(address => bool) private authorizedDevices;

    function authorizeDevice(address device) public {
        authorizedDevices[device] = true;
    }

    function deauthorizeDevice(address device) public {
        authorizedDevices[device] = false;
    }

    function isAuthorized(address device) public view returns (bool) {
        return authorizedDevices[device];
    }
}