// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract CallTools {
    function recursiveCall(bytes memory data, uint256 restLevel, uint256 successBits) public {
        bool success;
        if (restLevel >= 1) {
            (success, ) = address(this).call(abi.encodeWithSignature("recursiveCall(bytes,uint256,uint256)", data, restLevel - 1, successBits / 2));
            if(successBits & 1 == 0) {
                revert();
            }
        } else {
            // When restLevel reaches 0, call the contract itself with the given data.
            (success, ) = address(this).call(data);
        }
    }

    function multiCall(bytes[] memory callTasks, uint8[] memory returnFlags) public {
        require(callTasks.length == returnFlags.length, "Inconsistent length");
        for (uint i = 0; i < callTasks.length; i++) {
            (bool success, ) = address(this).call(callTasks[i]);
            uint8 returnFlag = returnFlags[0];

            /** Return Flag: 
                - 0: revert on error
                - 1: ignore error
                - 2: must error
                - 3: early stop on error
             */
            if (returnFlag == 2){
                revert();
            }
            if (!success) {
                if (returnFlag == 3) {
                    return;
                } else if (returnFlag == 0) {
                    revert();
                }
            }
        }
    }
}