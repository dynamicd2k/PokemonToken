pragma solidity ^0.8.0;

import './Exists.sol';
import './Card.sol';
import './PriceDifference.sol';

contract TradeCard is Card, Exists, PriceDifference{
    
    uint32 pd;
    
    bool tradeApprovalSender;
    
    bool tradeApprovalReceiver;
    
    event cardTradedSuccessfully(uint32 senderCardId, address senderCardIdNewOwner, uint32 receiverCardId, address receiverCardIdNewOwner);
    
    /**
     * @dev approveTradeCardBySender : function to initiate trade card can only be called by sender
     * @param _receiver : Receiver or second party
     * @param _senderCardId : Sender's card id
     * @param _receiverCardId : Receiver's card id
     */
    
    function approveTradeCardBySender(address payable _receiver, uint32 _senderCardId, uint32 _receiverCardId) public payable returns (uint8) {
        require(_exists(_senderCardId) == 1, "Card does not exists");
        require(_exists(_receiverCardId) == 1, "Card does not exists");
        require(_card[_senderCardId].owner== msg.sender, "Card should be owned by trade requestor to trade");
        require(_card[_receiverCardId].owner== _receiver, "Card requested to trade should be owned by receiver");
        if(_card[_receiverCardId].cardPriceInWei > _card[_senderCardId].cardPriceInWei){
            pd= getCardPriceDifference(_receiverCardId, _senderCardId);
            require(msg.value >= pd, "Sender needs to pay additional cost of card with this transaction. Please check the price difference and run the transaction again with sufficient msg.value");
            if(tradeApprovalReceiver== true){
                _receiver.transfer(pd);
                _card[_receiverCardId].owner= payable(msg.sender);
                _card[_senderCardId].owner=  payable (_receiver);
                emit cardTradedSuccessfully(_senderCardId, _card[_senderCardId].owner, _receiverCardId, _card[_receiverCardId].owner);
            }
            else{
                 require(tradeApprovalReceiver == true, "For balance transfer from sender, trade should be first approved by receiver and then called by sender");
            }
        }
        else{
            tradeApprovalSender=true;
            }
        return 0;
    }
    
    /**
     * @dev approveTradeCardByReceiver : function to initiate trade card can only be called by sender
     * @param _sender : Receiver or second party
     * @param _senderCardId : Sender's card id
     * @param _receiverCardId : Receiver's card id
     */
    
    function approveTradeCardByReceiver(address payable _sender, uint32 _senderCardId, uint32 _receiverCardId) public payable returns(uint8){
        require(_exists(_senderCardId) == 1, "Card does not exists");
        require(_exists(_receiverCardId) == 1, "Card does not exists");
        require(_card[_senderCardId].owner== _sender, "Card should be owned by trade requestor to trade");
        require(_card[_receiverCardId].owner== msg.sender, "Card requested to trade should be owned by receiver");
        if(_card[_senderCardId].cardPriceInWei > _card[_receiverCardId].cardPriceInWei){
            pd= getCardPriceDifference(_receiverCardId, _senderCardId);
            require(msg.value >= pd, "Receiver needs to pay additional cost of card with this transaction. Please check the price difference and run the transaction again with sufficient msg.value");
            if(tradeApprovalSender== true){
                _sender.transfer(pd);
                _card[_receiverCardId].owner= payable(_sender);
                _card[_senderCardId].owner=  payable (msg.sender);
                emit cardTradedSuccessfully(_senderCardId, _card[_senderCardId].owner, _receiverCardId, _card[_receiverCardId].owner);
            }
            else{
                 require(tradeApprovalReceiver == true, "For balance transfer from sender, trade should be first approved by receiver and then called by sender");
            }
        }
        else{
            tradeApprovalReceiver=true;
            }
        return 0;
    }
}    
