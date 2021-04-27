// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Election {
  address electionAuthority;
  string[] candidates; // Registered candidates
  mapping (string => uint) votes; // Candidate ID to number of votes
  mapping (address => bool) hasVoted; // If a registered voter has voted or not
  event Vote(string, address);
  bool isElectionStarted;
  bool isElectionEnded;

  constructor() public {
    electionAuthority = msg.sender;
  }

  modifier only_election_authority() {
    if (msg.sender != electionAuthority) revert();
    _;
  }
  
  modifier vote_only_once() {
    if (hasVoted[msg.sender]) revert();
    _;
  }

  modifier election_started() {
    if (isElectionStarted != true) revert();
    _;
  }

  modifier election_not_ended() {
    if (isElectionEnded == true) revert();
    _;
  }
  
  function start_election() public
    only_election_authority
  {
    isElectionStarted = true;
  }

  function end_election() public
    only_election_authority
  {
    isElectionEnded = true;
  }

  function register_candidate(string memory id) public
    only_election_authority
  {
    candidates.push(id);
  }
  
  function vote(string memory id) public
    vote_only_once
    election_started
    election_not_ended
  {
    votes[id] += 1;
    hasVoted[msg.sender] = true;
    emit Vote(id, msg.sender);
  }
  
  function get_num_candidates() public view returns(uint) {
    return candidates.length;
  }
  
  function get_candidate(uint i) public
    view returns(string memory _candidate, uint _votes)
  {
    _candidate = candidates[i];
    _votes = votes[_candidate];
  }
}
