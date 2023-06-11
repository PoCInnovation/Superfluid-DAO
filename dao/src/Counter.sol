// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Dao {

    struct Proposal {
        string description;
        uint voteCount;
        bool executed;
    }

    struct Member {
        address memberAddress;
        uint memberSince;
        uint tokenBalance;
    }

    address[] public members; // peut etre enlevé je pense on a déja membersInfo
    mapping(address => Member) public membersInfo;
    mapping(address => mapping(uint => bool)) public votes;
    Proposal[] public proposals;

    uint public totalSupply;
    mapping(address => uint) public balances; // peut etre enlevé je pense on a déja membersInfo

    event ProposalMake(uint indexed proposalId, string description);
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
        balances[_member] = 100;
        totalSupply += 100;
    }

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

        totalSupply -= balances[_member];
        balances[_member] = 0;

        /*

            require(membersInfo[_member].memberAddress != address(0), "Member doesn't exist");
            totalSupply -= balances[_member];
            delete membersInfo[_member];

            IMO

        */
    }

    function makeProposal(string memory _description) public { // demander pq memory (stock ou et pq)
        proposals.push (
            Proposal (
                {
                    description: _description,
                    voteCount: 0,
                    executed: false
                }
            )
        );
        emit ProposalMake((proposals.length - 1), _description);
    }

    function vote(uint _proposalId, uint _tokenAmout) public {
        require(membersInfo[msg.sender].memberAddress != address(0), "You are not a member");
        require(balances[msg.sender] >= _tokenAmout, "You don't have enough tokens to vote");
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
