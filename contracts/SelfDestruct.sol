// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ContractCanBeDestroyed {
    // non related to the selfdestruct, but just to have some state
    uint256 public number;

    function setNumber(uint256 newNumber) public {
        number = newNumber;
    }

    function increment() public {
        number++;
    }

    function destroy(address receiver) public {
        selfdestruct(payable(receiver));
    }

    receive() external payable {
        // This contract can receive ether
    }
}

contract SelfDestructTester {

    address public counterAddress;

    // call a deployed contract's destroy function and send ether to it
    function destroy(address payable toDestroy) public {
        ContractCanBeDestroyed destroyableContract = ContractCanBeDestroyed(toDestroy);

        destroyableContract.destroy(address(this));

        payable(address(toDestroy)).transfer(1 ether);
    }

    function deploy_and_destroy() public payable {
        ContractCanBeDestroyed counter = new ContractCanBeDestroyed();

        address payable paybleCounter = payable(address(counter));
        paybleCounter.transfer(1 ether);

        // Destroy the contract and send ether to this contract
        counter.destroy(address(this));
        paybleCounter.transfer(1 ether);
    }

    receive() external payable {
        // This contract can receive ether
    }
    
}

