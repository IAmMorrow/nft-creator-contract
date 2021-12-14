// contracts/TheFrontMan.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/interfaces/IERC20.sol";

interface INFTCreator {
    function createERC721(string memory collectionName, string memory itemName) external returns (address erc721Instance);
}
