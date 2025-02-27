// SPDX-License-Identifier: MIT

import '@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol';
import 'hardhat/console.sol';

contract ERC721EnumerableMock is ERC721Enumerable {
    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {}

    function baseURI() public view returns (string memory) {
        return _baseURI();
    }

    function exists(uint256 tokenId) public view returns (bool) {
        return _exists(tokenId);
    }

    function safeMint(address to, uint256 tokenId) public {
        _safeMint(to, tokenId);
    }

    function safeMintBatch(address to, uint256 quantity) public {
        uint256 _totalSupply = totalSupply();
        for(uint256 i = _totalSupply; i < (_totalSupply + quantity); i++) {
            _safeMint(to, i);
        }
    }

    function safeMint(
        address to,
        uint256 tokenId,
        bytes memory _data
    ) public {
        _safeMint(to, tokenId, _data);
    }

    function burn(uint256 start, uint256 num) public {
        uint256 end = start + num;
        for(uint256 i=start;i<end;i++){
            _burn(i);
        }
    }


    function benchmarkContractMethods(uint256 _tokenId, address _owner) public {
        
        console.log("benchmarkContractMethods ERC721EnumerableMock");
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