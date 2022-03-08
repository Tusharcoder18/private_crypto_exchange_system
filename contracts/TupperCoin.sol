pragma solidity ^0.8.11;
contract TupperCoin{
    uint public max_tuppercoins = 1000000;
    uint public inr_to_tuppercoins = 10;
    uint public total_tuppercoins_bought = 0;

    mapping(address => uint) equity_tuppercoins;
    mapping(address => uint) equity_inr;

    modifier can_buy_tuppercoins(uint inr_invested){
        require (inr_invested*inr_to_tuppercoins + total_tuppercoins_bought <= max_tuppercoins);
        _;
    }

    function equity_in_tuppercoins(address investor) external view returns(uint){
        return equity_tuppercoins[investor];
    }

    function equity_in_inr(address investor) external view returns(uint){
        return equity_inr[investor];
    }

    function buy_tuppercoins(address investor,uint inr_invested) external
    can_buy_tuppercoins(inr_invested){
        uint tuppercoins_bought = inr_invested * inr_to_tuppercoins;
        equity_tuppercoins[investor] += tuppercoins_bought;
        equity_inr[investor] = equity_tuppercoins[investor] / 10;
        total_tuppercoins_bought += tuppercoins_bought;
    }

    function sell_tuppercoins(address investor,uint tuppercoins_sold) external {
        equity_tuppercoins[investor] -= tuppercoins_sold;
        equity_inr[investor] = equity_tuppercoins[investor] / 10;
        total_tuppercoins_bought -= tuppercoins_sold;
    }

}