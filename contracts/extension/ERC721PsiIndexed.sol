// SPDX-License-Identifier: MIT
/**
  ______ _____   _____ ______ ___  __ _  _  _ 
 |  ____|  __ \ / ____|____  |__ \/_ | || || |
 | |__  | |__) | |        / /   ) || | \| |/ |
 |  __| |  _  /| |       / /   / / | |\_   _/ 
 | |____| | \ \| |____  / /   / /_ | |  | |   
 |______|_|  \_\\_____|/_/   |____||_|  |_|   
                                              
                                            
 */
pragma solidity ^0.8.0;

import "../BitMaps.sol";
import "../ERC721Psi.sol";


/**
    @dev This extension follows the AddressData format of ERC721A, so
    it can be a dropped-in replacement for the contract that requires AddressData
*/ 
abstract contract ERC721PsiIndexed is ERC721Psi {
    // Mapping owner address to address data
    mapping(address => uint16) _addressData;

    // Compiler will pack this into a single 256bit word.
    // struct AddressData {
    //     // Realistically, 2**64-1 is more than enough.
    //     uint64 balance;
    //     // Keeps track of mint count with minimal overhead for tokenomics.
    //     uint64 numberMinted;
    //     // Keeps track of burn count with minimal overhead for tokenomics.
    //     uint64 numberBurned;
    //     // For miscellaneous variable(s) pertaining to the address
    //     // (e.g. number of whitelist mint slots used).
    //     // If there are multiple variables, please pack them into a uint64.
    //     uint64 aux;
    // }


    /**
     * @dev See {IERC721-balanceOf}.
     */
    function balanceOf(address owner) 
        public 
        view 
        virtual 
        override 
        returns (uint256 _balance) 
    {
        require(owner != address(0), "ERC721Psi: balance query for the zero address");
        _balance = uint256(_addressData[owner]);   
    }

    /**
     * @dev Hook that is called after a set of serially-ordered token ids have been transferred. This includes
     * minting.
     *
     * startTokenId - the first token id to be transferred
     * quantity - the amount to be transferred
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero.
     * - `from` and `to` are never both zero.
     */
    function _afterTokenTransfers(
        address from,
        address to,
        uint256 startTokenId,
        uint256 quantity
    ) internal override virtual {
        require(quantity < 2 ** 16);
        uint16 _quantity = uint16(quantity);

        if(from != address(0)){
            _addressData[from] -= _quantity;
        } else {
            // Mint
            // _addressData[to].numberMinted += _quantity;
        }

        if(to != address(0)){
            _addressData[to] += _quantity;
        } else {
            // Burn
            // _addressData[to].numberBurned -= _quantity;
        }
        super._afterTokenTransfers(from, to, startTokenId, quantity);
    }


    // /**
    //  * @dev See {IERC721Enumerable-tokenByIndex}.
    //  */
    // function tokenByIndex(uint256 index) public view virtual override returns (uint256) {
    //     require(index < totalSupply(), "ERC721Psi: global index out of bounds");
        
    //     uint count;
    //     for(uint i; i < _minted; i++){
    //         if(_exists(i)){
    //             if(count == index) return i;
    //             else count++;
    //         }
    //     }
    // }

    // /**
    //  * @dev See {IERC721Enumerable-tokenOfOwnerByIndex}.
    //  */
    // function tokenOfOwnerByIndex(address owner, uint256 index) public view virtual override returns (uint256 tokenId) {
    //     uint count;
    //     for(uint i; i < _minted; i++){
    //         if(_exists(i) && owner == ownerOf(i)){
    //             if(count == index) return i;
    //             else count++;
    //         }
    //     }

    //     revert("ERC721Psi: owner index out of bounds");
    // }
}
