//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract MintBasicNFT is Script {
    string public constant Dog1 =
        "https://ipfs.io/ipns/k51qzi5uqu5dgtrhx1c0xgw06y6i5t7ycnmui9zhrf4l78qy080m7jmwzoiia4";

    function run() external {
        address mostRecentDeployment = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );
        mintNftOnContract(mostRecentDeployment);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(Dog1);
        vm.stopBroadcast();
    }
}
