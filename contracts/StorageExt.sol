// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "./InternalContracts/Contracts.sol";
import "./Storage.sol";
import "./CallTools.sol";

contract StorageExt is InternalContracts, Storage, CallTools {
    function setSponsored(address addr) public {
        address[] memory addrs = new address[](1);
        addrs[0] = addr;
        sponsorWhitelistControl.addPrivilege(addrs);
    }

    function resetSponsored(address addr) public {
        address[] memory addrs = new address[](1);
        addrs[0] = addr;
        sponsorWhitelistControl.removePrivilege(addrs);
    }
}