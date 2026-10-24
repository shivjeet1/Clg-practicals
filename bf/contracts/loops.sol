// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LoopingStatements {
    uint256 public sum;

    function forLoop(uint256 n) public {
        sum = 0;
        for (uint256 i = 1; i <= n; i++) {
            sum += i;
        }
    }

    function whileLoop(uint256 n) public {
        sum = 0;
        uint256 i = 1;
        while (i <= n) {
            sum += i;
            i++;
        }
    }

    function doWhileLoop(uint256 n) public {
        sum = 0;
        uint256 i = 1;
        do {
            sum += i;
            i++;
        } while (i <= n);
    }
}
