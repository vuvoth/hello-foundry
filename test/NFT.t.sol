// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "../src/NFT.sol";

contract CounterTest is Test {
    using stdStorage for StdStorage;
    NFT public nft;

    function setUp() public {
        nft = new NFT("NAME", "N");
    }

    function testMintToken() public {
        uint256 tokenId = nft.mintTo(address(1));
        assertEq(tokenId, 1);
        assertEq(nft.tokenURI(tokenId), "1");
    }

    function testAnother() public {
         uint256 slot = stdstore
            .target(address(nft))
            .sig("currentTokenId()")
            .find();
        bytes32 loc = bytes32(slot);
        bytes32 mockedCurrentTokenId = bytes32(abi.encode(10000));
        vm.store(address(nft), loc, mockedCurrentTokenId);

        assertEq(nft.currentTokenId(), 10000);
    }
}
