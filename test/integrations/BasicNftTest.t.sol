//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";

contract BasisNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant Dog1 =
        "https://ipfs.io/ipns/k51qzi5uqu5dgtrhx1c0xgw06y6i5t7ycnmui9zhrf4l78qy080m7jmwzoiia4";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory _name = "Dogie";
        string memory _nftName = basicNft.name();

        assert(
            keccak256(abi.encodePacked(_name)) ==
                keccak256(abi.encodePacked(_nftName))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(Dog1);

        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(Dog1)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}
