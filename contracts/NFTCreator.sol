// contracts/TheFrontMan.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";

import "./interfaces/INFTCreator.sol";
import "./ERC721Collection.sol";

contract NFTCreator is INFTCreator {
    string public constant SERVER_BASE_URI = "https://ADDRESS_DE_YASS/assets/";

    function createERC721(string memory name, string memory symbol) external returns (address) {
        // Create the contract for collection, setting the sender as the owner the collection (i.e.
        // contract).
        ERC721Collection erc721Instance = new ERC721Collection(msg.sender, name, symbol);

        // Set the storage URI, which the base URI where the collections will be stored.
        erc721Instance.setStorageURI(SERVER_BASE_URI);

        return address(erc721Instance);
    }
}
