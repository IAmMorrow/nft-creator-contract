// contracts/TheFrontMan.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/INFTCreator.sol";
import "./ERC721Collection.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";

contract NFTCreator is INFTCreator {
    function createERC721(string memory name, string memory symbol) external returns (address) {
        ERC721Collection erc721Instance = new ERC721Collection(name, symbol);
        erc721Instance.setStorageURI("https://ADDRESS_DE_YASS.com/assets/");

        return address(erc721Instance);
    }
}
