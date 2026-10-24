// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MessageStorage {
    string private message;

    // Event to emit when the message is updated
    event MessageUpdated(string newMessage);

    // Function to set the message
    function setMessage(string memory newMessage) public {
        message = newMessage;
        emit MessageUpdated(newMessage);
    }

    // Function to get the current message
    function getMessage() public view returns (string memory) {
        return message;
    }
}
