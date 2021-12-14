// contracts/TheFrontMan.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface INFTCreator {
    /**
     * @dev Emitted when `tokenId` token is transferred from `from` to `to`.
     */
    event CollectionCreated(address indexed collection, address indexed creator);

    /**
     * @dev Return all collections created by `owner`
     */
    function collectionsByOwner(address owner) external view returns (address[] memory);

    /**
     * @dev Create a new ERC721 contract and give it to the sender
     */
    function createERC721(string memory name, string memory symbol) external returns (address);
}
