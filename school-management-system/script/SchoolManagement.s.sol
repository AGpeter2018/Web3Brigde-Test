// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {SchoolManagement} from "../src/SchoolManagement.sol";
import {SchoolToken} from "src/SchoolToken.sol";

contract CounterScript is Script {
    SchoolManagement public SchoolManagementIns;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        uint256 initialSupply = 1_000_000 * 10**18; 
SchoolToken token = new SchoolToken(initialSupply);

        SchoolManagementIns = new SchoolManagement(address(token));

        vm.stopBroadcast();
    }
}
