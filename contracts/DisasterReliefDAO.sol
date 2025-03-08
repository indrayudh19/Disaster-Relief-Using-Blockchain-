// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/governance/Governor.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorSettings.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorCountingSimple.sol";
import "@openzeppelin/contracts/governance/extensions/GovernorVotes.sol";

contract DisasterReliefDAO is Governor, GovernorSettings, GovernorCountingSimple {
    constructor()
        Governor("DisasterReliefDAO")
        GovernorSettings(1 /* voting delay */, 10 /* voting period */, 0 /* proposal threshold */)
    {}

    // Explicitly specify overridden contracts for votingDelay
    function votingDelay() public view override(Governor, GovernorSettings) returns (uint256) {
        return 1; // Voting starts immediately
    }

    // Explicitly specify overridden contracts for votingPeriod
    function votingPeriod() public view override(Governor, GovernorSettings) returns (uint256) {
        return 10; // Voting lasts 10 blocks (~2 minutes)
    }

    // Explicitly specify overridden contracts for proposalThreshold
    function proposalThreshold() public view override(Governor, GovernorSettings) returns (uint256) {
        return 0; // Anyone can propose
    }

    // Required for OpenZeppelin Governor v5+
    function quorum(uint256) public pure override returns (uint256) {
        return 1; // Minimum 1 vote to pass
    }

    // Required for OpenZeppelin Governor v5+ (timestamp mode)
    function clock() public view override returns (uint48) {
        return uint48(block.timestamp);
    }

    // Required for OpenZeppelin Governor v5+
    function CLOCK_MODE() public pure override returns (string memory) {
        return "mode=timestamp";
    }

    // Simplified voting power logic (1 vote per address for demo)
    function _getVotes(address, uint256, bytes memory) internal pure override returns (uint256) {
        return 1;
    }
}


