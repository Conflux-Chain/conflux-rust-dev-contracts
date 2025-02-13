// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "../InternalContracts/CrossSpaceCall.sol";

contract CrossSpaceTraceTestConfluxSide {
    CrossSpaceCall constant CROSS_SPACE = CrossSpaceCall(0x0888000000000000000000000000000000000006);

    function callEVMEmpty(bytes20 addr) external {
        CROSS_SPACE.callEVM(addr, abi.encodeCall(CrossSpaceTraceTestEVMSide.callEmpty,()));
    }

    function callEVM(bytes20 addr, uint256 depth) external {
        CROSS_SPACE.callEVM(addr, abi.encodeCall(CrossSpaceTraceTestEVMSide.call, depth));
    }

    function callEVMAndSetStorage(bytes20 addr, uint256 depth) external {
        CROSS_SPACE.callEVM(addr, abi.encodeCall(CrossSpaceTraceTestEVMSide.call, depth));

        assembly {
            sstore(0, 1)
        }
    }

    function staticCallEVM(bytes20 addr, uint256 depth) external view {
        CROSS_SPACE.staticCallEVM(addr, abi.encodeCall(CrossSpaceTraceTestEVMSide.call, depth));
    }

    function createEVM(bytes calldata init) external {
        CROSS_SPACE.createEVM(init);
    }

    function transferEVM(bytes20 addr) external payable {
        CROSS_SPACE.transferEVM{ value: msg.value / 2 }(addr);
        CROSS_SPACE.transferEVM{ value: msg.value / 2 }(addr);
    }

    function withdrawFromMapped(uint256 value) external {
        CROSS_SPACE.withdrawFromMapped(value);
    }

    function fail(bytes20 addr) external {
        CROSS_SPACE.callEVM(addr, abi.encodeCall(CrossSpaceTraceTestEVMSide.fail, ()));
    }

    function subcallFail(bytes20 addr) external {
        try CROSS_SPACE.callEVM(addr, abi.encodeCall(CrossSpaceTraceTestEVMSide.fail, ())) {
            revert("Should fail");
        } catch Error (string memory /*reason*/) {
            // EMPTY
        }
    }
}

contract CrossSpaceTraceTestEVMSide {
    function callEmpty() external {
    }

    function call(uint256 depth) external returns (uint256) {
        if (depth == 0) return 0;
        this.call(depth - 1);
        return depth;
    }

    function fail() external pure {
        revert("Oh no!");
    }
}
