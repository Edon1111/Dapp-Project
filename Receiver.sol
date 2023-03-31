
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

 contract Receiver {


    struct ReceiverDetails {
        uint totalFunds;
        uint amount;
        uint money;

    }


    ReceiverDetails rd ;


    function withdrawMoney(uint _money) public  m_checkBalance  {
        
        rd.money = _money;
        rd.totalFunds = rd.totalFunds - rd.money;
        
    }

    modifier m_checkBalance(){

        _;

        require(rd.money < rd.totalFunds, "Not enough funds on account");

        
    }


    function deposit(uint _amount) internal {

        rd.amount = _amount;
        rd.totalFunds = rd.totalFunds  + rd.amount;

    }

    function getBalance() public view returns(uint){

        return rd.totalFunds;
    }


    


    

}