// contracts/TheFrontMan.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";

import "./interfaces/INFTCreator.sol";
import "./ERC721Collection.sol";

contract NFTCreator is INFTCreator {
    mapping(address => address[]) private _collectionsByOwner;
    string public constant SERVER_BASE_URI = "https://ADDRESS_DE_YASS/assets/";

    function collectionsByOwner(address owner) public view returns (address[] memory) {
        return _collectionsByOwner[owner];
    }

    function createERC721(string memory name, string memory symbol) external returns (address) {
        address creator = msg.sender;

        // Create the contract for collection, setting the sender as the owner the collection (i.e.
        // contract).
        ERC721Collection collection = new ERC721Collection(name, symbol, SERVER_BASE_URI);
        address          colAddress = address(collection);

        // Save relation between the creator and and newly created collection.
        _collectionsByOwner[creator].push(colAddress);

        emit CollectionCreated(colAddress, creator);

        return colAddress;
    }
}
