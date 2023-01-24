// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./GameNFT.sol";
import "./SportyToken.sol";

contract GameMarketplace {
    SportyToken private _token;
    GameNFT private _game;

    address private _organiser;

    constructor(SportyToken token, GameNFT game) public {
        _token = token;
        _game = game;
        _organiser = _game.getOrganiser();
    }

    event Purchase(address indexed buyer, address seller, uint256 ticketId);

    // Purchase tickets from the organiser directly
    function purchaseTicket() public {
        address buyer = msg.sender;

        _token.transferFrom(buyer, _organiser, _game.getTicketPrice());

        _game.transferTicket(buyer);
    }

    // Purchase ticket from the secondary market hosted by organiser
    function secondaryPurchase(uint256 ticketId) public {
        address seller = _game.ownerOf(ticketId);
        address buyer = msg.sender;
        uint256 sellingPrice = _game.getSellingPrice(ticketId);
        uint256 commision = (sellingPrice * 10) / 100;

        _token.transferFrom(buyer, seller, sellingPrice - commision);
        _token.transferFrom(buyer, _organiser, commision);

        _game.secondaryTransferTicket(buyer, ticketId);

        emit Purchase(buyer, seller, ticketId);
    }
}