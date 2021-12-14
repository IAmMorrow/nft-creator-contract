// contracts/TheFrontMan.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";

import "./interfaces/INFTCreator.sol";
import "./ERC721Collection.sol";

contract NFTCreator is INFTCreator {
    mapping(address => address[]) private _collectionsByOwner;
    string public constant SERVER_BASE_URI = "https://ADDRESS_DE_YASS/assets/";

    function addressToString(address _addr) private pure returns(string memory) {
        bytes32 value = bytes32(uint256(uint160(_addr)));
        bytes memory alphabet = "0123456789abcdef";

        bytes memory str = new bytes(51);
        str[0] = "0";
        str[1] = "x";
        for (uint i = 0; i < 20; i++) {
            str[2+i*2] = alphabet[uint(uint8(value[i + 12] >> 4))];
            str[3+i*2] = alphabet[uint(uint8(value[i + 12] & 0x0f))];
        }
        return string(str);
    }

    function collectionsByOwner(address owner) public view returns (address[] memory) {
        return _collectionsByOwner[owner];
    }

    function createERC721(string memory name, string memory symbol) external returns (address) {
        // Create the contract for collection, setting the sender as the owner the collection (i.e.
        // contract).
        ERC721Collection erc721Instance = new ERC721Collection(msg.sender, name, symbol);

        // Set the storage URI, which the base URI where the collections will be stored.
        erc721Instance.setStorageURI(string(abi.encodePacked(SERVER_BASE_URI, addressToString(address(erc721Instance)), "/")));

        _collectionsByOwner[msg.sender].push(address(erc721Instance));
        emit CollectionCreated(address(erc721Instance), msg.sender);
        return address(erc721Instance);
    }
}
