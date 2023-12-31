// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadMan{
    address public owner;
    address payable public presetAddress;
    uint256 public lastBlock;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor(address payable _presetAddress) {
        owner = msg.sender;
        lastBlock = block.number;
        presetAddress = _presetAddress;
    }

    function stillAlive() external onlyOwner {
        lastBlock = block.number;
    }

    function executeDeadMan() external {
        require(block.number - lastBlock > 10, "Still alive");
        selfdestruct(payable(presetAddress));
    }
}
