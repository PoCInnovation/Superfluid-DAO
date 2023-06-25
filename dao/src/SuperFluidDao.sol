// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// import {ISuperToken} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol";

import {SuperFluidToken} from "./SuperFluidToken.sol";

interface ISuperFluidDao {
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
    error NotEnoughSuperfluidToken();
    error ZeroSuperfluidToken();
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

    function getToken() external view returns (SuperFluidToken);

    function getProposal(
        uint _proposalId
    ) external view returns (Proposal memory);

    function getProposals() external view returns (Proposal[] memory);
}

contract SuperFluidDao is ISuperFluidDao {
    mapping(address => mapping(uint256 => VoteStatus)) private _votes;
    Proposal[] private _proposals;
    SuperFluidToken private _superFluidToken;

    constructor() {
        _superFluidToken = new SuperFluidToken();
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

    function getToken() public view returns (SuperFluidToken) {
        return _superFluidToken;
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

        uint256 voteWeight = _superFluidToken.balanceOf(msg.sender);

        if (voteWeight == 0) {
            revert ZeroSuperfluidToken();
        }

        if (voteChoice) {
            _proposals[proposalId].voteFor += voteWeight;
            _votes[msg.sender][proposalId] = VoteStatus.VotedFor;
        } else {
            _proposals[proposalId].voteAgainst += voteWeight;
            _votes[msg.sender][proposalId] = VoteStatus.VotedAgainst;
        }
        
        _superFluidToken.burn(msg.sender, 1);

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

        if (_proposals[proposalId].voteFor > _proposals[proposalId].voteAgainst) {
            _superFluidToken.mint(msg.sender, _proposals[proposalId].voteFor);
        }
        if (_proposals[proposalId].voteFor < _proposals[proposalId].voteAgainst) {
            _superFluidToken.burn(msg.sender, 1);
        }
    }
}
