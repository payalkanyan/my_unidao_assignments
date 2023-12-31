// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.18; 
 
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol"; 
import "@openzeppelin/contracts/access/Ownable.sol"; 
 
contract CharactersNFT is ERC721Enumerable, Ownable { 
    uint256 public constant MAX_NFT_SUPPLY = 3000; 
    string private _baseTokenURI; 
    uint256 private _currentTokenId = 1; 
    mapping(uint256 => string) private _tokenImages; 
    mapping(uint256 => string) private _tokenURIs; 
 
    constructor(string memory name, string memory symbol, string memory baseTokenURI) ERC721(name, symbol) { 
        _baseTokenURI = baseTokenURI; 
    } 
 
    function mintNFT(string memory customImage) external { 
        require(_currentTokenId <= MAX_NFT_SUPPLY, "Max NFT supply reached"); 
        uint256 tokenId = _currentTokenId; 
        _safeMint(msg.sender, tokenId); 
        _setTokenURI(tokenId); 
        _tokenImages[tokenId] = customImage; 
        _currentTokenId++; 
    } 
 
    function changeImage(uint256 tokenId, string memory newImage) external onlyOwner { 
        require(_exists(tokenId), "Token does not exist"); 
        _tokenImages[tokenId] = newImage; 
    } 
 
    function _setTokenURI(uint256 tokenId) internal override { 
        require(_exists(tokenId), "Token does not exist"); 
        string memory tokenURI = bytes(_baseTokenURI).length > 0 
            ? string(abi.encodePacked(_baseTokenURI, tokenId.toString())) 
            : ""; 
        _tokenURIs[tokenId] = tokenURI; 
    } 
 
    function getImage(uint256 tokenId) external view returns (string memory) { 
        return _tokenImages[tokenId]; 
    } 
 
    function setURI(string memory baseTokenURI) external onlyOwner { 
        _baseTokenURI = baseTokenURI; 
    } 
}