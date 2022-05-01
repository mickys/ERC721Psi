// SPDX-License-Identifier: MIT
// Creators: Chiru Labs

pragma solidity ^0.8.0;

import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/security/ReentrancyGuard.sol';
import "erc721a/contracts/ERC721A.sol";
import '@openzeppelin/contracts/utils/Strings.sol';
import 'hardhat/console.sol';

contract ERC721AMock is ERC721A {
    constructor(string memory name_, string memory symbol_) ERC721A(name_, symbol_) {}

    function numberMinted(address owner) public view returns (uint256) {
        return _numberMinted(owner);
    }

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

    function burn(uint256 start, uint256 num) public {
        uint256 end = start + num;
        for(uint256 i=start;i<end;i++){
            _burn(i);
        }
    }

    function benchmarkContractMethods(uint256 _tokenId, address _owner) public {
        
        console.log("benchmarkContractMethods ERC721AMock");
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
