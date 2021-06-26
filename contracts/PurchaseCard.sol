pragma solidity ^0.8.0;

/**
 * @title PurchaseCard
 * @dev Purchase Pokemon card
 */
 
import './Exists.sol';
import './Card.sol';

contract PurchaseCard is Card, Exists{
    
    event cardPurchased(uint32 cardPurchasedId, address newOwner, uint32 purchasePrice);
    
     /**
     * @dev purchaseCard : function to initiate trade card can only be called by sender
     * @param _purchaseCardId : Card id to purchase
     */
     
    function purchaseCard(uint32 _purchaseCardId) public payable returns(uint8){
        require(_exists(_purchaseCardId) == 1, "Card does not exists");
        require(_card[_purchaseCardId].owner == admin, "Card is not available for purchase");
        require(msg.sender.balance> _card[_purchaseCardId].cardPriceInWei, "User does not have enough ether");
        require(msg.value >= _card[_purchaseCardId].cardPriceInWei, "Purchase token: Not sufficient funds");
        _card[_purchaseCardId].owner = payable(msg.sender);
        _balances[msg.sender]= _balances[msg.sender]+1;
        _balances[admin]= _balances[admin]-1;
        emit cardPurchased(_purchaseCardId, _card[_purchaseCardId].owner, _card[_purchaseCardId].cardPriceInWei);
        return 0;
    }
}