// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "../InternalContracts/ConfluxContext.sol";

contract ContextUser {
    event Notify(uint256);

    function getBlockNumber() external returns (uint256) {
        emit Notify(block.number);
        return block.number;
    }

    function getEpochNumber() external returns (uint256) {
        uint256 epochNumber = ConfluxContext(0x0888000000000000000000000000000000000004).epochNumber();
        emit Notify(epochNumber);
        return epochNumber;
    }
}