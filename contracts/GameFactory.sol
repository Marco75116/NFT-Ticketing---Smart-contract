// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./GameNFT.sol";
import "./GameMarketplace.sol";

contract GameFactory is Ownable {
    struct Game {
        string gameName;
        string gameSymbol;
        uint256 ticketPrice;
        uint256 totalSupply;
        address marketplace;
    }

    address[] private activeFests;
    mapping(address => Game) private activeFestsMapping;

    event Created(address ntfAddress, address marketplaceAddress);

    // Creates new NFT and a marketplace for its purchase
    function createNewGame(
        SportyToken token,
        string memory gameName,
        string memory gameSymbol,
        uint256 ticketPrice,
        uint256 totalSupply
    ) public onlyOwner returns (address) {
        GameNFT newGame =
            new GameNFT(
                gameName,
                gameSymbol,
                ticketPrice,
                totalSupply,
                msg.sender
            );

        GameMarketplace newMarketplace =
            new GameMarketplace(token, newGame);

        address newFestAddress = address(newGame);

        activeFests.push(newFestAddress);
        activeFestsMapping[newFestAddress] = Game({
            gameName: gameName,
            gameSymbol: gameSymbol,
            ticketPrice: ticketPrice,
            totalSupply: totalSupply,
            marketplace: address(newMarketplace)
        });

        emit Created(newFestAddress, address(newMarketplace));

        return newFestAddress;
    }

    // Get all active fests
    function getActiveGame() public view returns (address[] memory) {
        return activeFests;
    }

    // Get fest's details
    function getFestDetails(address gameAddress)
        public
        view
        returns (
            string memory,
            string memory,
            uint256,
            uint256,
            address
        )
    {
        return (
            activeFestsMapping[gameAddress].gameName,
            activeFestsMapping[gameAddress].gameSymbol,
            activeFestsMapping[gameAddress].ticketPrice,
            activeFestsMapping[gameAddress].totalSupply,
            activeFestsMapping[gameAddress].marketplace
        );
    }
}