// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// import { ISuperToken } from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol";

contract Dao {

    struct Proposal {
        uint voteCount;
        bool executed;
    }

// must be deleted and replace it's usage
    struct Member {
        address memberAddress;
        uint memberSince;
        uint tokenBalance;
    }

    address[] private members; // peut etre enlevé je pense on a déja membersInfo
    mapping(address => Member) private membersInfo;
    mapping(address => mapping(uint => bool)) private votes;
    Proposal[] private proposals;

    uint private totalSupply;

    event ProposalMade(uint indexed proposalId, string description);
    event VoteCast(address indexed voter, uint indexed proposalId, uint tokenAmount);

    function addMember(address _member) public {
        require(membersInfo[_member].memberAddress == address(0), "Member already exists");
        membersInfo[_member] = Member (
            {
                memberAddress: _member,
                memberSince: block.timestamp,
                tokenBalance: 100
            }
        );

        members.push(_member);
        membersInfo[_member].tokenBalance = 100;
        totalSupply += 100;
    }

// must be intern gestion
function removeMember(address _member) public {
        require(membersInfo[_member].memberAddress != address(0), "Member doesn't exist");
        membersInfo[_member] = Member(address(0), 0, 0);

        for (uint i = 0; i < members.length; i++) {
            if (members[i] == _member) {
                members[i] = members[members.length - 1];
                members.pop();
                break;
            }
        }

        totalSupply -= membersInfo[_member].tokenBalance;
        membersInfo[_member].tokenBalance = 0;
    }

    function makeProposal(string calldata _description) public { // demander pq memory (stock ou et pq)
        proposals.push (
            Proposal (
                {
                    voteCount: 0,
                    executed: false
                }
            )
        );
        emit ProposalMade((proposals.length - 1), _description);
    }

    function vote(uint _proposalId, uint _tokenAmout) public {
        require(membersInfo[msg.sender].memberAddress != address(0), "You are not a member");
        require(membersInfo[msg.sender].tokenBalance >= _tokenAmout, "You don't have enough tokens to vote");
        require(votes[msg.sender][_proposalId] == false, "You already voted for this proposal");
        votes[msg.sender][_proposalId] = true;
        membersInfo[msg.sender].tokenBalance -= _tokenAmout;
        proposals[_proposalId].voteCount += _tokenAmout;

        emit VoteCast(msg.sender, _proposalId, _tokenAmout);
    }

    function executeProposal(uint _proposalId) public {
        require(proposals[_proposalId].executed == false, "This proposal has already been executed");
        require(proposals[_proposalId].voteCount > (totalSupply / 2), "This proposal has not been accepted");
        proposals[_proposalId].executed = true;
    }
}