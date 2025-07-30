// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract Receivable {
    receive() external payable {
        assembly {
            sstore(0, 1)
        }
    }
}
