pragma solidity ^0.8.0;

/**
 * @title PriceDifference
 * @dev to check price difference between two cards
 */
 
import './Exists.sol';
import './Card.sol';

contract PriceDifference is Card, Exists{
    
    uint32 priceDifference;
    
    /**
     * @dev function to initiate trade card can only be called by sender
     * @param _card1 : First card id
     * @param _card2 : Second card id
     */
     
    function getCardPriceDifference(uint32 _card1, uint32 _card2) public payable returns(uint32){
        if(_card[_card1].cardPriceInWei> _card[_card2].cardPriceInWei)
            priceDifference = _card[_card1].cardPriceInWei - _card[_card2].cardPriceInWei;
        else
            priceDifference = _card[_card2].cardPriceInWei - _card[_card1].cardPriceInWei;
        return priceDifference;
    }
       
}