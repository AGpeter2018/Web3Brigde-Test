// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {Todo} from "../src/Todo.sol";

contract CounterScript is Script {
    Todo public todoIns;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        todoIns = new Todo();

        vm.stopBroadcast();
    }
}
