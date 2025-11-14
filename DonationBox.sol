//SPDX-Licence-Identifier: MIT

pragma solidity ^0.8.0;

contract DonationBox{
    address public owner;
    uint public goal;
    uint256 public deadline;
    uint public totalRaised;
    bool public GoalReached;
    bool public fundsWithdrawn;
    

    event DonationReceived (address donot, uint amout);
    event Withdraw  (address donot, uint amout);
    

    constructor( uint _goal, uint256 _durationMinutes){  
        owner = msg.sender;
        goal = _goal;
        deadline = block.timestamp + _durationMinutes;
    }


    modifier onlyOwner (){
        require(msg.sender == owner, "you are not the owner");
        _;
    }

      
    function getTimeLeft() public view returns (uint256) {
        if (block.timestamp >= deadline) return 0;
        return deadline - block.timestamp;
    }


    function donate() public payable {
        require(msg.value > 0 , "value cant be empty");
        totalRaised += msg.value;
        if ( totalRaised >= goal  ){
            GoalReached = true;
        }
        emit DonationReceived(msg.sender, msg.value);

    }


    function withdrawFunds() public { 
        require(block.timestamp >= deadline || totalRaised >= goal, "time is up");
        uint amount = address(this).balance;
        payable(owner).transfer(amount);
        emit Withdraw(owner,amount);

    }

    

    function getBalance () public view returns (uint){
        return address(this).balance;
    }
} 