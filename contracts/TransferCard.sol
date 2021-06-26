pragma solidity ^0.8.0;

/**
 * @title TransferCard
 * @dev Transfer Pokemon card
 */
 
import './Exists.sol';
import './Card.sol';

contract TransferCard is Card, Exists{
    
    event cardTransferred(uint32 cardTransferredId, address newOwner);
    
    /**
     * @dev transferCard : function to initiate trade card can only be called by sender
     * @param _cardId : Current card id
     * @param _to : receiver's address
     */
    function transferCard(uint32 _cardId, address _to) public returns(uint8){
        require(_card[_cardId].owner == msg.sender, "Card can only be transferred by the owner");
        require(_to != admin, "Cards should be sold and not transferred to Contract address");
        require(_to != address(0), "To address is invalid");
        _card[_cardId].owner = payable (_to);
        _balances[msg.sender]= _balances[msg.sender]-1;
        _balances[_to]= _balances[_to]+1;
        emit cardTransferred(_cardId, _card[_cardId].owner);
        return 0;
    }
}