
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

contract Transaction{

    struct Transactions {
        address address_from;
        address address_to;
        uint amount;
        uint timestamp;
    }

    Transactions[] public transactionList;

    mapping (uint => Transactions) public trn;
    uint counter = 0 ;

    function addTransaction(address _address_from, address _address_to, uint _amount, uint _timestamp)internal{
        
      
        Transactions memory newTransaction = Transactions(_address_from, _address_to, _amount, _timestamp);
        transactionList.push(newTransaction);
        trn[counter] = newTransaction;
        counter++;

    }

    function getTransactions() public view returns(Transactions[] memory){

        return transactionList;
    }

    // function getTransactionById(uint _index)public view returns(Transactions memory){
    //     return trn[_index] ;
    // }

    function getNumberOfTransactions() public view returns(uint){
        return counter;
    }

    function getLastTransaction(uint no_transactions) public view returns(Transactions memory){
        uint x = transactionList.length - no_transactions;
        return trn[x];
    }


}