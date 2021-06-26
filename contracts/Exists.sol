pragma solidity ^0.8.0;

/**
 * @title Exists
 * @dev Check if a Pokemon card exists
 */
 
import './Card.sol';

contract Exists is Card{

    /**
     * @dev _exists : function to initiate trade card can only be called by sender
     * @param _cardId : Current card id
     */
    
    function _exists(uint32 _cardId) internal returns (uint8) {
        if( _card[_cardId].owner != address(0))
            flag =1;
        else
            flag =0;
        return flag;
    }
}