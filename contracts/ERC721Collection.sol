// contracts/StakeGameToken.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ERC721Collection is IERC721Metadata, ERC721, ERC721Enumerable, AccessControl {
    using Counters for Counters.Counter;
    Counters.Counter private _mintedTokens;

    string private _storageURI;
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    constructor(string memory name, string memory symbol, string memory baseURI) ERC721(name, symbol) {
        address creator = msg.sender;

        // Set the admin role to the owner of the contract.
        _setupRole(DEFAULT_ADMIN_ROLE, creator);
        _setupRole(MINTER_ROLE, creator);
        _setupRole(BURNER_ROLE, creator);

        // Set storage URI.
        _storageURI = string(abi.encodePacked(baseURI, addressToString(address(this))));
    }

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

    function supportsInterface(bytes4 interfaceId) public view virtual override(AccessControl, ERC721, IERC165, ERC721Enumerable) returns (bool) {
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC721Metadata).interfaceId ||
            interfaceId == type(AccessControl).interfaceId ||
            interfaceId == type(ERC721Enumerable).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    function setStorageURI(string memory storageURI) public onlyRole(DEFAULT_ADMIN_ROLE) {
        _storageURI = storageURI;
    }

    function _baseURI() internal view override returns (string memory) {
        return _storageURI;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override(ERC721, ERC721Enumerable) {
        ERC721._beforeTokenTransfer(from, to, tokenId);
        ERC721Enumerable._beforeTokenTransfer(from, to, tokenId);
    }

    function mint(address to) public onlyRole(MINTER_ROLE) returns (uint256) {
        _mintedTokens.increment();

        uint256 newTokenId = _mintedTokens.current();
        _mint(to, newTokenId);

        return newTokenId;
    }

    function batchMint(address to, uint256 quantity) public onlyRole(MINTER_ROLE) returns(uint256[] memory) {
        uint256[] memory mintedIds = new uint[](quantity);
        for (uint256 i = 0; i < quantity; i++) {
            mintedIds[i] = mint(to);
        }

        return mintedIds;
    }

    function burn(uint256 tokenId) public onlyRole(BURNER_ROLE) {
        _burn(tokenId);
    }
}
