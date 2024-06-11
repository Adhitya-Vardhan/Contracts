
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.12;

contract Simpletransfer {
  
  address Owner;

    constructor(){
        Owner=msg.sender;
    }
    
    modifier Only_owner{
        require(msg.sender == Owner,"you are not authoriesed to do this transaction");
        _;
    }
   event Transfer(address _from, address _to,uint256);

  // to tranfer money from one user account to anoter user account
    function sendMoney(address payable  _to) public payable {
           require(_to!=address(0),"its not a valid address");
           require(msg.value<msg.sender.balance,"not enough Eth in your account");
           _to.transfer(msg.value);
           emit Transfer(msg.sender,_to,msg.value);
    }

// to tranfer ether from user to smart contract
    function deposit() public payable  {
              require(msg.value<=msg.sender.balance,"not enough eth");
    }

    function getBalance() public view returns(uint256){
        return address(this).balance;
    }



   function withdraw(address _to,uint256 _amount) public {
      
      (bool success, ) = _to.call{value: _amount}("");
    require(success, "Failed to send Ether");

   }
  


}

