// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {SuperfluidDaoToken} from "./SuperfluidDaoToken.sol";
import {ISuperToken} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol";

interface ISuperfluidDao {
    struct Proposal {
        uint256 voteFor;
        uint256 voteAgainst;
        uint64 createdAt;
        uint64 dueDate;
        address author;
        bytes32 descriptionCID; // ipfs description cid
        bool executed;
    }

    enum VoteStatus {
        NotVoted,
        VotedFor,
        VotedAgainst
    }

    // error
    error InvalidProposalId();
    error AlreadyVoted();
    error NotEnoughSuperfluidDaoToken();
    error ZeroSuperfluidDaoToken();
    error ProposalAlreadyExecuted();
    error ProposalDueDateNotReached();
    error ProposalDueDatePassed();
    error ProposalExecutedByNonAuthor();

    // events
    event ProposalSubmitted(uint indexed proposalId);
    event CastVote(
        address indexed voter,
        uint indexed proposalId,
        uint tokenAmount
    );

    // functions
    function postProposal(bytes32 descriptionCID, uint64 timeSpan) external;

    function getToken() external view returns (SuperfluidDaoToken);

    function getProposal(
        uint _proposalId
    ) external view returns (Proposal memory);

    function getProposals() external view returns (Proposal[] memory);
}

contract SuperfluidDao is ISuperfluidDao {
    mapping(address => mapping(uint256 => VoteStatus)) private _votes;
    Proposal[] private _proposals;
    SuperfluidDaoToken private _superfluidToken;

    constructor() {
        _superfluidToken = new SuperfluidDaoToken();
    }

    function postProposal(bytes32 descriptionCID, uint64 timeSpan) public {
        _proposals.push(
            Proposal({
                descriptionCID: descriptionCID,
                createdAt: uint64(block.timestamp),
                dueDate: uint64(block.timestamp + timeSpan),
                voteFor: 0,
                voteAgainst: 0,
                author: msg.sender,
                executed: false
            })
        );

        emit ProposalSubmitted(_proposals.length - 1);
    }

    function getToken() public view returns (SuperfluidDaoToken) {
        return _superfluidToken;
    }

    function getProposal(
        uint256 proposalId
    ) external view returns (Proposal memory) {
        return _proposals[proposalId];
    }

    function getProposals() external view returns (Proposal[] memory) {
        return _proposals;
    }

    function vote(uint256 proposalId, bool voteChoice) public {
        if (proposalId >= _proposals.length) {
            revert InvalidProposalId();
        }
        if (_proposals[proposalId].executed) {
            revert ProposalAlreadyExecuted();
        }
        if (_votes[msg.sender][proposalId] != VoteStatus.NotVoted) {
            revert AlreadyVoted();
        }
        if (block.timestamp >= _proposals[proposalId].dueDate) {
            revert ProposalDueDatePassed();
        }

        uint256 voteWeight = ISuperToken(address(_superfluidToken)).balanceOf(
            msg.sender
        );

        if (voteWeight == 0) {
            revert ZeroSuperfluidDaoToken();
        }

        if (voteChoice) {
            _proposals[proposalId].voteFor += voteWeight;
            _votes[msg.sender][proposalId] = VoteStatus.VotedFor;
        } else {
            _proposals[proposalId].voteAgainst += voteWeight;
            _votes[msg.sender][proposalId] = VoteStatus.VotedAgainst;
        }

        _superfluidToken.burn(msg.sender, 1);

        emit CastVote(msg.sender, proposalId, voteWeight);
    }

    function executeProposal(uint256 proposalId) public {
        if (proposalId >= _proposals.length) {
            revert InvalidProposalId();
        }
        if (_proposals[proposalId].executed) {
            revert ProposalAlreadyExecuted();
        }
        if (block.timestamp < _proposals[proposalId].dueDate) {
            revert ProposalDueDateNotReached();
        }
        if (_proposals[proposalId].author != msg.sender) {
            revert ProposalExecutedByNonAuthor();
        }

        _proposals[proposalId].executed = true;

        if (
            _proposals[proposalId].voteFor > _proposals[proposalId].voteAgainst
        ) {
            _superfluidToken.mint(msg.sender, _proposals[proposalId].voteFor);
        }
        if (
            _proposals[proposalId].voteFor < _proposals[proposalId].voteAgainst
        ) {
            _superfluidToken.burn(msg.sender, 1);
        }
    }
}
