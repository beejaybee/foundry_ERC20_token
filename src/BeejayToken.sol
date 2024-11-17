// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import { ERC20 } from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract BeejayToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("BeejayToken", "BJT") {
        _mint(msg.sender, initialSupply);
    }
}