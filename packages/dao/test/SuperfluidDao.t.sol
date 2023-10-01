// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/SuperfluidDao.sol";
import {SuperfluidDaoToken} from "../src/SuperfluidDaoToken.sol";
import {ISuperfluid, ISuperToken, ISuperApp} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";
import {SuperTokenV1Library} from "@superfluid-finance/ethereum-contracts/contracts/apps/SuperTokenV1Library.sol";
import {CFAv1Forwarder} from "@superfluid-finance/ethereum-contracts/contracts/utils/CFAv1Forwarder.sol";

contract SuperfluidDaoTest is Test {
    using SuperTokenV1Library for ISuperToken;

    address Isma = vm.addr(0x1);
    address Lyam = vm.addr(0x2);
    SuperfluidDao Dao;
    CFAv1Forwarder public _cfaForwarder;
    ISuperfluid public _host;

    function setUp() public {
        Dao = new SuperfluidDao();
        _host = ISuperfluid(0x22ff293e14F1EC3A09B137e9e06084AFd63adDF9);
        _cfaForwarder = CFAv1Forwarder(
            0xcfA132E353cB4E398080B9700609bb008eceB125
        );
        mintTo(Isma, 100000000000);
        vm.startPrank(Isma);
        address payable daoToken = payable(address(Dao.getToken()));
        _cfaForwarder.grantPermissions(ISuperToken(daoToken), daoToken);
        vm.stopPrank();
    }

    function mintTo(address to, uint256 amount) public {
        vm.startPrank(address(Dao));
        SuperfluidDaoToken token = Dao.getToken();
        token.mint(to, amount);
        vm.stopPrank();
    }

    function test_postProposal() public {
        Dao.postProposal("Donnez moins d'argent a Isma", 10);
        assertEq(Dao.getProposals().length, 1);
    }

    function test_VoteInvalidProposalId() public {
        vm.expectRevert(ISuperfluidDao.InvalidProposalId.selector);
        Dao.vote(0, true);
    }

    function test_VoteProposalAlreadyExecuted() public {
        vm.startPrank(Isma);
        Dao.postProposal("Donnez moins d'argent a Isma", 0);
        Dao.executeProposal(0);
        vm.expectRevert(ISuperfluidDao.ProposalAlreadyExecuted.selector);
        Dao.vote(0, true);
        vm.stopPrank();
    }

    function test_VoteAlreadyVoted() public {
        mintTo(Isma, 2);
        Dao.postProposal("Donnez moins d'argent a Isma", 10);
        vm.startPrank(Isma);
        Dao.vote(0, false);
        vm.expectRevert(ISuperfluidDao.AlreadyVoted.selector);
        Dao.vote(0, false);
        vm.stopPrank();
    }

    function test_VoteProposalDueDatePassed() public {
        mintTo(Isma, 2);
        Dao.postProposal("Donnez moins d'argent a Isma", 0);
        vm.startPrank(Isma);
        vm.expectRevert(ISuperfluidDao.ProposalDueDatePassed.selector);
        Dao.vote(0, true);
        vm.stopPrank();
    }

    function test_VoteZeroSuperfluidDaoToken() public {
        Dao.postProposal("Donnez moins d'argent a Isma", 10);
        vm.startPrank(Lyam);
        vm.expectRevert(ISuperfluidDao.ZeroSuperfluidDaoToken.selector);
        Dao.vote(0, true);
        vm.stopPrank();
    }

    function test_voteProposal() public {
        mintTo(Isma, 1);
        vm.startPrank(Isma);
        Dao.postProposal("Donnez moins d'argent a Isma", 10);
        Dao.vote(0, true);
        ISuperfluidDao.Proposal memory proposal = Dao.getProposal(0);
        assert(proposal.voteFor >= 0);
        vm.stopPrank();
    }

    function test_ExecuteProposalInvalidProposalId() public {
        vm.expectRevert(ISuperfluidDao.InvalidProposalId.selector);
        Dao.executeProposal(0);
    }

    function test_ExecuteProposalProposalAlreadyExecuted() public {
        vm.startPrank(Isma);
        Dao.postProposal("Donnez moins d'argent a Isma", 0);
        Dao.executeProposal(0);
        vm.expectRevert(ISuperfluidDao.ProposalAlreadyExecuted.selector);
        Dao.executeProposal(0);
        vm.stopPrank();
    }

    function test_ExecuteProposalProposalDueDateNotReached() public {
        vm.startPrank(Isma);
        Dao.postProposal("Donnez moins d'argent a Isma", 100000000000);
        vm.expectRevert(ISuperfluidDao.ProposalDueDateNotReached.selector);
        Dao.executeProposal(0);
        vm.stopPrank();
    }

    function test_ExecuteProposalProposalExecutedByNonAuthor() public {
        Dao.postProposal("Donnez moins d'argent a Isma", 0);
        vm.startPrank(Isma);
        vm.expectRevert(ISuperfluidDao.ProposalExecutedByNonAuthor.selector);
        Dao.executeProposal(0);
        vm.stopPrank();
    }

    function test_executeProposal() public {
        mintTo(Isma, 1);
        vm.startPrank(Isma);
        Dao.postProposal("Donnez moins d'argent a Isma", 1);
        Dao.vote(0, true);
        ISuperfluidDao.Proposal memory proposal = Dao.getProposal(0);
        vm.warp(proposal.dueDate + 1);
        Dao.executeProposal(0);
        vm.stopPrank();
    }

    event LogIntValue(uint8 value);

    function test_allow_flow() public {
        mintTo(Isma, 1000);
        vm.startPrank(Isma);
        ISuperToken test = ISuperToken(address(Dao.getToken()));

        _cfaForwarder.grantPermissions(test, address(Dao.getToken()));

        (uint8 flow_permisions, ) = _cfaForwarder.getFlowOperatorPermissions(
            test,
            Isma,
            address(Dao.getToken())
        );

        assertEq(flow_permisions, 7);
        vm.stopPrank();
    }

    function test_create_flow() public {
        vm.startPrank(Isma);

        address payable daoToken = payable(address(Dao.getToken()));

        _cfaForwarder.grantPermissions(ISuperToken(daoToken), daoToken);


        int96 prevFlowRate = _cfaForwarder.getFlowrate(ISuperToken(daoToken), Isma, daoToken);

        console2.log(prevFlowRate);
        console2.log(ISuperToken(daoToken).balanceOf(Isma));
        SuperfluidDaoToken(daoToken).createFlowIntoContract(
                ISuperToken(daoToken),
                1000,
                Isma
            );
        int96 prevFlowRate2 = _cfaForwarder.getFlowrate(ISuperToken(daoToken), Isma, daoToken);
        console2.log(prevFlowRate2);
        vm.stopPrank();
    }
}
