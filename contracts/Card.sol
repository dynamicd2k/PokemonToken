pragma solidity ^0.8.0;

/**
 * @title Card
 * @dev Pokemon card
 */
 
contract Card{
    struct card {
        address payable owner;
        uint8 power;
        uint32 card_Id;
        uint32 cardPriceInWei;
        string avatar;
        string symbol;
        string rarity;
    }
    
    uint8 internal flag =0; 
    
    uint32 internal cardId;
    
    address payable internal admin;
    
     // card_id array to loop thorugh card ids in a faster way
    uint32[] internal cardIds;
    
    //Mapping cardid to card index in cardIds array
    mapping (uint32 => uint) internal _cardIndex;
    
    //Mapping cardId to Card structure
    mapping (uint32 => card) internal _card;
    
    //Mapping user address to card count tracked via _balances
    mapping (address => uint256) internal _balances;
}