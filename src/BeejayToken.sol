// SPDX-License-Identifier: MIT

pragma solidity 0.8.27;

import { ERC20 } from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract BeejayToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("PREME_BASE", "$PREME") {
        _mint(msg.sender, initialSupply);
    }
}