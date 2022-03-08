// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.11;

contract HelloWorld {
    string public name;

    constructor() {
        name = "Dummy";
    }

    function setName(string memory nm) public {
        name = nm;
    }
}