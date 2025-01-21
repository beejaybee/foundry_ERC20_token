// SPDX-License-Identifier:MIT

pragma solidity 0.8.27;

import {Script} from "forge-std/Script.sol";
import {BeejayToken} from "src/BeejayToken.sol";

contract DeployBeejayToken is Script {
    uint256 public constant INITIAL_SUPPLY = 10000000000 ether;

    BeejayToken beejayToken;
    function run() external returns(BeejayToken) {
        vm.startBroadcast();
        beejayToken = new BeejayToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return beejayToken;
    }
}