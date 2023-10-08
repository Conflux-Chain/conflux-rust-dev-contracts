// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FixedSupplyToken is ERC20 {
    constructor() ERC20("FIXED", "Example Fixed Supply Token") {
        uint decimals = 18;
        uint _totalSupply = 10000000 * 10**uint(decimals);
        _mint(msg.sender, _totalSupply);
    }
}