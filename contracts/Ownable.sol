pragma solidity ^0.6.0;

contract Ownable {
  address payable _owner;

  constructor() public {
    _owner = msg.sender;
  }

  modifier onlyOwner() {
    require(IsOwner(), "You are not the owner");
    _;
  }

  function IsOwner() view public returns(bool) {
    return (msg.sender == _owner);
  }
}

 
