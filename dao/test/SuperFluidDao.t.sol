// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/SuperFluidDao.sol";
import {SuperFluidToken} from "../src/SuperFluidToken.sol";

contract SuperFluidDaoTest is Test {

    address Isma = vm.addr(0x1);
    SuperFluidDao Dao;

    function setUp() public {
        Dao = new SuperFluidDao();
    }

    function mintTo(address to, uint256 amount) public {
        vm.startPrank(address(Dao));
        SuperFluidToken token = Dao.getToken();
        token.mint(to, amount);
        vm.stopPrank();
    }

    function test_postProposal() public {
        Dao.postProposal("Donnez moins d'argent a Isma", 10);
        assertEq(Dao.getProposals().length, 1);
    }

    function test_VoteInvalidProposalId() public {
        vm.expectRevert(ISuperFluidDao.InvalidProposalId.selector);
        Dao.vote(0, true);
    }

    function test_VoteProposalAlreadyExecuted() public {
        vm.startPrank(Isma);
        Dao.postProposal("Donnez moins d'argent a Isma", 0);
        Dao.executeProposal(0);
        vm.expectRevert(ISuperFluidDao.ProposalAlreadyExecuted.selector);
        Dao.vote(0, true);
        vm.stopPrank();
    }

    function test_VoteAlreadyVoted() public {
        mintTo(Isma, 2);
        Dao.postProposal("Donnez moins d'argent a Isma", 10);
        vm.startPrank(Isma);
        Dao.vote(0, false);
        vm.expectRevert(ISuperFluidDao.AlreadyVoted.selector);
        Dao.vote(0, false);
        vm.stopPrank();
    }

    function test_VoteProposalDueDatePassed() public {
        mintTo(Isma, 2);
        Dao.postProposal("Donnez moins d'argent a Isma", 0);
        vm.startPrank(Isma);
        vm.expectRevert(ISuperFluidDao.ProposalDueDatePassed.selector);
        Dao.vote(0, true);
        vm.stopPrank();
    }

    function test_VoteZeroSuperfluidToken() public {
        Dao.postProposal("Donnez moins d'argent a Isma", 10);
        vm.startPrank(Isma);
        vm.expectRevert(ISuperFluidDao.ZeroSuperfluidToken.selector);
        Dao.vote(0, true);
        vm.stopPrank();
    }

    function test_voteProposal() public {
        mintTo(Isma, 1);
        vm.startPrank(Isma);
        Dao.postProposal("Donnez moins d'argent a Isma", 10);
        Dao.vote(0, true);
        ISuperFluidDao.Proposal memory proposal = Dao.getProposal(0);
        assertEq(proposal.voteFor, 1);
        vm.stopPrank();
    }

    function test_ExecuteProposalInvalidProposalId() public {
        vm.expectRevert(ISuperFluidDao.InvalidProposalId.selector);
        Dao.executeProposal(0);
    }

    function test_ExecuteProposalProposalAlreadyExecuted() public {
        vm.startPrank(Isma);
        Dao.postProposal("Donnez moins d'argent a Isma", 0);
        Dao.executeProposal(0);
        vm.expectRevert(ISuperFluidDao.ProposalAlreadyExecuted.selector);
        Dao.executeProposal(0);
        vm.stopPrank();
    }

    function test_ExecuteProposalProposalDueDateNotReached() public {
        vm.startPrank(Isma);
        Dao.postProposal("Donnez moins d'argent a Isma", 100000000000);
        vm.expectRevert(ISuperFluidDao.ProposalDueDateNotReached.selector);
        Dao.executeProposal(0);
        vm.stopPrank();
    }

    function test_ExecuteProposalProposalExecutedByNonAuthor() public {
        Dao.postProposal("Donnez moins d'argent a Isma", 0);
        vm.startPrank(Isma);
        vm.expectRevert(ISuperFluidDao.ProposalExecutedByNonAuthor.selector);
        Dao.executeProposal(0);
        vm.stopPrank();
    }

    function test_executeProposal() public {
        mintTo(Isma, 1);
        vm.startPrank(Isma);
        Dao.postProposal("Donnez moins d'argent a Isma", 1);
        Dao.vote(0, true);
        ISuperFluidDao.Proposal memory proposal = Dao.getProposal(0);

        while (block.timestamp >= proposal.dueDate)
    
        Dao.executeProposal(0);
        vm.stopPrank();
    }
}
