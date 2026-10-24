// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RestrictedAccessContract {
    address public owner;
    uint256 public someData;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function setSomeData(uint256 newData) public onlyOwner {
        someData = newData;
    }

    function getSomeData() public view returns (uint256) {
        return someData;
    }
}
