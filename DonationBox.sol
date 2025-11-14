//SPDX-Licence-Identifier: MIT

pragma solidity ^0.8.0;

contract DonationBox{
    address public owner;
    uint public goal = 100;
    uint256 public deadline;
    uint public totalRaised;
    bool public GoalReached;
    bool public fundsWithdrawn;

    event DonationReceived (address donot, uint amout);
    event Withdraw  (address donot, uint amout);
    

    constructor( uint goal, uint _deadline){  
        owner = msg.sender;
        goal = 100000;
        deadline =  2 days;
    }

    modifier onlyOwner (){
        require(msg.sender == owner, "you are not the owner");
        _;
    }
    function getTmeLeft(uint secondsPassed) public view returns (bool) {
        uint256 timeLeft = block.timestamp;
        return timeLeft >= deadline + secondsPassed;

    }

    function donate() public payable {
        require(msg.value > 0 , "value cant be empty");
        totalRaised += msg.value;
        emit DonationReceived(msg.sender, msg.value);
    }

    function withdraw() public { 
        uint amount = address(this).balance;
        payable(owner).transfer(amount);
    emit Withdraw(owner,amount);

    }

    function getBalance () public view returns (uint){
        return address(this).balance;
    }
} 