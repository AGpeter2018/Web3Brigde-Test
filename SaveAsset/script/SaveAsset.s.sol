// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {SaveAsset} from "../src/SaveAsset.sol";
import {ERC20} from "src/ERC20.sol";

contract CounterScript is Script {
    SaveAsset public SaveAssetIns;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

       ERC20 token = new ERC20();
       SaveAsset saveAsset = new SaveAsset(address(token));

        vm.stopBroadcast();
    }
}
