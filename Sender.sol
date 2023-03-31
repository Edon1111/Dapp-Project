

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

import "./Transaction.sol";
import "./Receiver.sol";

contract Sender is Transaction, Receiver {


    uint256 public amount;
    uint256 public TotalFunds;
    address receiver ;
    string public message;
    string public cardNumber ;
    string public cvv;
    uint256 public TotalAmount ;
    uint public firstTransferTime;



    constructor (uint256 _totalFunds) {
        // cardNumber = _cardNumber;
        // cvv = _cvv;
        TotalFunds = _totalFunds;
    }



    uint public callCount = 0 ;
    bool public callPutCard = false ;

    function sendMoney( uint _amount, address _receiver) public payable m_validAddress(_receiver) m_ifCardExists m_transferLimit{
        receiver = _receiver;
        amount = _amount;
        callCount += 1;
                   
                 if(TotalFunds > 0 && TotalFunds > amount){
                    TotalFunds -= amount;
                    TotalAmount += amount;
                    
                    
                    addTransaction(msg.sender,receiver, amount, block.timestamp);
                    deposit(amount);
                    message = "Transfer completed";
                    
                    //getOutCard();
                 }
                 else{
                     revert("Not enough funds");
                 }

            }

    function setCard(string memory _cardNumber, string memory _cvv) public  m_checkCard {

            cardNumber = _cardNumber;
            cvv = _cvv;
            callPutCard = true;
            firstTransferTime = block.timestamp;

    }

   

    function getOutCard() public  {
       callPutCard = false;

    }



    modifier m_validAddress(address _addr) {
        receiver = _addr;
        require(_addr != address(0), "This address doesn't exists");

        _;
    }

   

    modifier m_ifCardExists() {

        require(callPutCard != false,"Please insert your card");

        _;
    }

     modifier m_checkCard() {
         

        _;
       require(bytes(cardNumber).length == 8 && bytes(cvv).length == 3, "No valid credit card");
    
        
    }

    modifier m_transferLimit(){
         
        if(callCount >= 5 && block.timestamp <= (firstTransferTime + 24 hours)){
            callCount = 0;
            assert(callCount == 0);
            revert("only 5 transactions per day" );
            
        }

        if(callCount <= 5 && block.timestamp >= (firstTransferTime + 24 hours)){
            callCount = 0;
             assert(callCount == 0);
            firstTransferTime = block.timestamp;
        }

        _;


    }


    function getTime() public view returns(uint ){
        return  block.timestamp;
    }

    
}



