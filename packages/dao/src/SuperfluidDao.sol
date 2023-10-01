// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {SuperfluidDaoToken} from "./SuperfluidDaoToken.sol";
import {ISuperfluid, ISuperToken, ISuperApp} from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";
import {SuperTokenV1Library} from "@superfluid-finance/ethereum-contracts/contracts/apps/SuperTokenV1Library.sol";
import {CFAv1Forwarder} from "@superfluid-finance/ethereum-contracts/contracts/utils/CFAv1Forwarder.sol";

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
    error InvalidCFAPermissions();

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
    mapping(address voter => mapping(uint256 proposalId => VoteStatus))
        private _votes;
    Proposal[] private _proposals;
    SuperfluidDaoToken private _superfluidToken;
    address constant SUPER_TOKEN_FACTORY =
        0x94f26B4c8AD12B18c12f38E878618f7664bdcCE2;
    CFAv1Forwarder public _cfaForwarder;
    ISuperfluid public _host;
    int96 public flowRate = 1000; // This is to fix idk why calcul not good
    ISuperToken public _DaoToken;

    constructor() {
        _superfluidToken = new SuperfluidDaoToken();
        _superfluidToken.initialize(
            SUPER_TOKEN_FACTORY,
            "SuperfluidDaoToken",
            "SDT"
        );
        _host = ISuperfluid(0x22ff293e14F1EC3A09B137e9e06084AFd63adDF9);
        _cfaForwarder = CFAv1Forwarder(
            0xcfA132E353cB4E398080B9700609bb008eceB125
        );
        _DaoToken = ISuperToken(address(_superfluidToken));

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

        uint256 voteWeight = _DaoToken.balanceOf(
            msg.sender
        );

        if (voteWeight <= 0) {
            revert ZeroSuperfluidDaoToken();
        }
        (uint8 flow_permisions, ) = _cfaForwarder.getFlowOperatorPermissions(
            _DaoToken,
            msg.sender,
            address(_superfluidToken)
        );

        if (flow_permisions != 7) {
            revert InvalidCFAPermissions();
        }

        // Here we have we are sure we have flow_perm at 7
        _superfluidToken.createFlowIntoContract(
            _DaoToken,
            flowRate,
            msg.sender
        );

        if (voteChoice) {
            _proposals[proposalId].voteFor += voteWeight;
            _votes[msg.sender][proposalId] = VoteStatus.VotedFor;
        } else {
            _proposals[proposalId].voteAgainst += voteWeight;
            _votes[msg.sender][proposalId] = VoteStatus.VotedAgainst;
        }

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
