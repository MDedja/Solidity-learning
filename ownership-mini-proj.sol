// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Ownership{
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Not owner");
        _;
    }

    function changeOwner(address newOwner) external onlyOwner{
        require(newOwner != address(0), "Zero address");
        owner = newOwner;
    }

    function getOwner() external view returns(address){
        return owner;
    }
}