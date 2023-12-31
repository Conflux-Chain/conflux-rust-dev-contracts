// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

import "./InternalContracts/Contracts.sol";

contract CommissionPrivilegeTest is InternalContracts {
    mapping(uint => uint) public ss;

    function add(address account) public payable {
        address[] memory a = new address[](1);
        a[0] = account;
        sponsorWhitelistControl.addPrivilege(a);
    }

    function remove(address account) public payable {
        address[] memory a = new address[](1);
        a[0] = account;
        sponsorWhitelistControl.removePrivilege(a);
    }

    function foo() public payable {
    }

    function par_add(uint start, uint end) public {
        for (uint i = start; i < end; i++) {
            ss[i] = 1;
        }
    }
    function par_del(uint start, uint end) public {
        for (uint i = start; i < end; i++) {
            ss[i] = 0;
        }
    }
    function par(uint s1, uint e1, uint s2, uint e2) public {
        this.par_add(s1, e1);
        this.par_del(s1, e1);
        this.par_del(s2, e2);
        this.par_add(s2, e2);
    }
    function par_add_del(uint s1, uint e1, uint s2, uint e2) public {
        this.par_add(s1, e1);
        this.par_del(s2, e2);
        this.par_del(s1, e1);
        this.par_add(s2, e2);
    }
    function rec(uint l, uint r, uint d) public payable {
        if (d == 0) {
            for (uint i = l; i < r; i++) {
                ss[i] = 0;
            }
        } else {
            for (uint i = l; i < r; i++) {
                ss[i] = d % 2;
            }
            rec(l + 1, r - 1, d - 1);
        }
    }
}