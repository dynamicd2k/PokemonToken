pragma solidity ^0.8.0;

/**
 * @title PokemonToken
 * @dev Mint , sell and purchase Pokemon token
 */
 
import './Card.sol';
import './MintCard.sol';
import './SellCard.sol';
import './Exists.sol';
import './PurchaseCard.sol';
import './TransferCard.sol';
import './SetCardPrice.sol';
import './TradeCard.sol';
import './PriceDifference.sol';

contract PokemonToken is Card, Exists, PriceDifference, SellCard, MintCard, PurchaseCard, TransferCard, SetCardPrice, TradeCard {
    

    constructor() payable {
        admin=payable (msg.sender);
        cardId=0;
    }
    
    /**
     * @dev getCardPrice : function to initiate trade card can only be called by sender
     * @param _cardId : Current card id
     */

    function getCardPrice(uint32 _cardId) public view returns(uint256){
        return _card[_cardId].cardPriceInWei;
    }
    
    /**
     * @dev balanceOf : function to initiate trade card can only be called by sender
     * @param _cardOwner : Owner of current card
     */
    
    function balanceOf(address _cardOwner) public view returns (uint) {
        require(_cardOwner != address(0), "Balance query for the zero address");
        return _balances[_cardOwner];
    }

    /**
     * @dev viewCardByCardId : function to initiate trade card can only be called by sender
     * @param _cardId : Id of current card
     */
    function viewCardByCardId(uint32 _cardId) public returns(card memory){
        require(_exists(_cardId)==1, "Card does not exist");
        return _card[_cardId];
    }
    
    /**
     * @dev viewAllCards : function to initiate trade card can only be called by sender
     */
    
    // function viewAllCards() public view returns(uint32[] memory){
    //     return cardIds;
    // }

}