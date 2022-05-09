// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import '../extension/ERC721PsiIndexed.sol';
import "hardhat/console.sol";


contract ERC721PsiIndexedMock is ERC721PsiIndexed {
    constructor(string memory name_, string memory symbol_) ERC721Psi(name_, symbol_) {}


    function baseURI() public view returns (string memory) {
        return _baseURI();
    }

    function exists(uint256 tokenId) public view returns (bool) {
        return _exists(tokenId);
    }

    function safeMint(address to, uint256 quantity) public {
        _safeMint(to, quantity);
    }

    function safeMint(
        address to,
        uint256 quantity,
        bytes memory _data
    ) public {
        _safeMint(to, quantity, _data);
    }

    function getBatchHead(
        uint256 tokenId
    ) public view {
        _getBatchHead(tokenId);
    }

    function benchmarkContractMethods(uint256 _tokenId, address _owner) public {
        
        console.log("benchmarkContractMethods ERC721PsiIndexedMock");
        console.log("  - _tokenId:   ", _tokenId);
        console.log("  - _owner:     ", _owner);
        console.log("  - totalSupply:", totalSupply());

        // ownerOf
        uint256 gasBefore = gasleft();
        address owner = ownerOf(_tokenId);
        uint256 gasAfter = gasleft();
        console.log("  - gas:", gasBefore - gasAfter, "method ownerOf(_tokenId) - owner:", owner);

        // balanceOf
        gasBefore = gasleft();
        uint256 _balance = balanceOf(_owner);
        gasAfter = gasleft();
        console.log("  - gas:", gasBefore - gasAfter, "method balanceOf(_owner) - _balance:", _balance);

        // ownerOf
        gasBefore = gasleft();
        uint256 _tokenOfOwnerByIndex = tokenOfOwnerByIndex(_owner, _balance - 1);
        gasAfter = gasleft();
        console.log("  - gas:", gasBefore - gasAfter, "method tokenOfOwnerByIndex(_tokenId) - _token:", _tokenOfOwnerByIndex);

    }

}