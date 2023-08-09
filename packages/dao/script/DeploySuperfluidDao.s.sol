// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import {SuperfluidDaoToken} from "../src/SuperfluidDaoToken.sol";
import {ISuperToken} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol";

address constant SUPER_TOKEN_FACTORY = 0x94f26B4c8AD12B18c12f38E878618f7664bdcCE2;

contract DeploySuperfluidDao is Script {
    SuperfluidDaoToken public token;

    function run() public {
        token = new SuperfluidDaoToken();

        token.initialize(SUPER_TOKEN_FACTORY, "SuperfluidDaoToken", "SDT");

        token.mint(address(this), 2000000);

        console.log(ISuperToken(address(token)).balanceOf(address(this)));
    }
}
