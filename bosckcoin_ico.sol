pragma solidity ^0.4.11;

contract bosckcoin_ico {
    
    //introducing the maximum of Bosckcoins available for sale
    uint public max_bosckcoins = 1000000;
    
    //introducing the USD to Bosckcoins conversion rate
    uint public usd_to_bosckcoins = 1000;
    
    //introducing the total number of Bosckcoins that have been bought by the investors
    uint public total_bosckcoins_bought = 0;
    
    //mapping from the investor address to its equity in Bosckcoins and USD 
    mapping(address => uint) equity_bosckcoins;
    mapping(address => uint) equity_usd;
    
    //check if an investor can buy Bosckcoins
    modifier can_buy_bosckcoins(uint usd_invested) {
        require (usd_invested * usd_to_bosckcoins + total_bosckcoins_bought <= max_bosckcoins);
        _;
    }
    
    //getting the equity in bosckcoins of an investor
    function equity_in_bosckcoins(address investor) external constant returns(uint){
        return equity_bosckcoins[investor];
    }
    
    //getting the equity in usd of an investor
    function equity_in_usd(address investor) external constant returns(uint){
        return equity_usd[investor];
    }
    
    //Buying bosckcoins
    function buy_bosckcoins(address investor, uint usd_invested) external
    can_buy_bosckcoins(usd_invested) {
        uint bosckcoins_bought = usd_invested * usd_to_bosckcoins;
        equity_bosckcoins[investor] += bosckcoins_bought;
        equity_usd[investor] =equity_bosckcoins[investor] / 1000;
        total_bosckcoins_bought += bosckcoins_bought;
    }
    
    //selling bosckcoins
    function sell_bosckcoins(address investor, uint bosckcoins_sold) external {
        equity_bosckcoins[investor] -= bosckcoins_sold;
        equity_usd[investor] =equity_bosckcoins[investor] / 1000;
        total_bosckcoins_bought -= bosckcoins_sold;
    }
    
}