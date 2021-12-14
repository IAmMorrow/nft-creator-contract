// contracts/StakeGameToken.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract ERC721Collection is IERC721Metadata, ERC721, AccessControl {
    string private _storageURI;
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    constructor(address admin, string memory name, string memory symbol) ERC721(name, symbol) {
        // Set the admin role to the owner of the contract.
        _setupRole(DEFAULT_ADMIN_ROLE, admin);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(AccessControl, ERC721, IERC165) returns (bool) {
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC721Metadata).interfaceId ||
            interfaceId == type(AccessControl).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    function setStorageURI(string memory storageURI) public {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "Authorized operation");
        _storageURI = storageURI;
    }

    function _baseURI() internal view override returns (string memory) {
        return _storageURI;
    }

}
