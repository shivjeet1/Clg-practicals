// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CryptographicFunctions {
    // Hash Function
    function sha256Hash(string memory data) public pure returns (bytes32) {
        return sha256(bytes(data));
    }

    // Keccak256 (SHA3) Hash Function
    function keccak256Hash(string memory data) public pure returns (bytes32) {
        return keccak256(bytes(data));
    }

    // RIPEMD160 Hash Function
    function ripemd160Hash(string memory data) public pure returns (bytes20) {
        return ripemd160(bytes(data));
    }

    // HMAC (Hash-based Message Authentication Code)
    function calculateHMAC(bytes memory key, string memory message)
        public
        pure
        returns (bytes32)
    {
        return sha256(abi.encodePacked(key, message));
    }
}
