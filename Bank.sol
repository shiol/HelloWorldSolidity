// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PiggyBank {
    address payable public owner;
    
    struct Depositor {
        uint256 totalDeposited;
        uint256 depositCount;
    }
    
    mapping(address => Depositor) public deposits;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {
        require(msg.value > 0, "value must be greater than zero");
        deposits[msg.sender].totalDeposited += msg.value;
        deposits[msg.sender].depositCount++;
    }

    function deposit() external payable {
        require(msg.value > 0, "value must be greater than zero");
        deposits[msg.sender].totalDeposited += msg.value;
        deposits[msg.sender].depositCount++;
    }

    function withdraw() public {
        require(msg.sender == owner, "only owner can withdraw");
        require(address(this).balance > 0, "balance must be greater than zero");
        owner.transfer(address(this).balance);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function getDeposit(address _depositor) public view returns (uint256 count, uint256 total) {
        require(deposits[_depositor].depositCount > 0, "invalid address");
        Depositor storage d = deposits[_depositor];
        return (d.depositCount, d.totalDeposited);
    }
}