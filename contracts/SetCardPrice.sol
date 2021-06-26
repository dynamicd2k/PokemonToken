pragma solidity ^0.8.0;

/**
 * @title SetCardPrice
 * @dev Set purchase price of Pokemon card
 */
 
import './Exists.sol';
import './Card.sol';

contract SetCardPrice is Card, Exists{

    event cardPriceSet(uint32 cardId, uint32 newPrice, address priceSetBy);
  
     /**
     * @dev setCardPrice : function to mint tokens with ETH
     * @param _cardId - id of card
     * @param _newPrice - new Price
     */
     
    function setCardPrice(uint32 _cardId, uint32 _newPrice) public returns(uint8){
        require(_card[_cardId].owner==msg.sender, "Only card owner can set the price");
        _card[_cardId].cardPriceInWei = _newPrice;
        emit cardPriceSet(_cardId, _card[_cardId].cardPriceInWei, msg.sender);
        return 0;
    }   
}