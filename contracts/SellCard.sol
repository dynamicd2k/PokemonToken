pragma solidity ^0.8.0;

/**
 * @title SellCard
 * @dev Sell Pokemon Card
 */

import './Exists.sol';
import './Card.sol';

contract SellCard is Card, Exists{
    
    event cardSold(uint32 cardSoldId, address newOwner, uint32 sellPrice);
    
     /**
     * @dev sellCard : function to sell card to contract address in exchange of ether
     * @param _sellCardId - id of card to be sold.
     */
    function sellCard(uint32 _sellCardId) public payable returns(uint8){
        require(_exists(_sellCardId) == 1, "Card does not exists");
        require(admin.balance> _card[_sellCardId].cardPriceInWei,"Contract admin does not have sufficient balance");
        require(_card[_sellCardId].owner == msg.sender, "Only owner of the card can sell the card");
        _card[_sellCardId].owner.transfer(_card[_sellCardId].cardPriceInWei);                                           // Payment from contract to owner
        _card[_sellCardId].owner= admin;
        _balances[msg.sender]= _balances[msg.sender]-1;
        _balances[admin]= _balances[admin]+1;
        emit cardSold(_sellCardId, _card[_sellCardId].owner, _card[_sellCardId].cardPriceInWei);
        return 0;
    }
}