// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/SuperFluidDao.sol";


contract SuperFluidDaoTest is Test {

    address Isma = vm.addr(0x1);
    SuperFluidDao dao;

    function setUp() public {
        dao = new SuperFluidDao();
    }

    function setUp_Proposal() public {
        dao.postProposal("Donnez moins d'argent a Isma", 10);
    }

    // function test_getProposal() public {
    //     setUp_Proposal();
    //     assertEq(
    // }
}
