pragma solidity ^0.8.0;

/**
 * @title MintCard
 * @dev Mint Pokemon cards
 */
 
import './Card.sol';

contract MintCard is Card{
    
    event newCardMinted(uint32 cardId, string avatar, uint8 power, string symbol, string rarity, uint32 cardPrice, address card_owner);
    
    /**
     * @dev function to confirm if gas fees is paid to Dbilia and trigger mintWithUSD
     * @param _avatar - input parameter
     * @param _power  - input parameter
     * @param _symbol - input parameter
     * @param _rarity - input parameter
     */
    
     
     function mintCard(string memory _avatar, uint8 _power, string memory _symbol, string memory _rarity) public returns(uint8){
        require(msg.sender.balance>0, "Buyer account has insuffiecient Ether balance");
        require(msg.sender==admin, "Only contract admin can mint cards");
        cardId=cardId+1;
        cardIds.push(cardId);
        _cardIndex[cardId] = cardIds.length-1;
        _card[cardId].card_Id = cardId;
        _card[cardId].owner= payable (msg.sender);
        _card[cardId].avatar= _avatar;
        _card[cardId].power= _power;
        _card[cardId].symbol= _symbol;
        _card[cardId].rarity= _rarity;
        _card[cardId].cardPriceInWei=100;                                               //Price of card is initially set at 100 wei on minting   
        _balances[msg.sender]= _balances[msg.sender]+1;
        emit newCardMinted(cardId, _avatar, _power, _symbol, _rarity, _card[cardId].cardPriceInWei, msg.sender);
        return 0;
    }
}