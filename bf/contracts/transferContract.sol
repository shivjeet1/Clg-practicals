// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract TransferContract {
    address public recipient;

    event EtherTransferred(address indexed from, address indexed to, uint256 amount);

    constructor(address _recipient) {
        recipient = _recipient;
    }

    function transfer() public payable {
        require(msg.value >= 5, "Amount should be greater than 0");
        payable(recipient).transfer(msg.value);
        emit EtherTransferred(msg.sender, recipient, msg.value);
    }
}
