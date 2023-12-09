// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface ILicenseProposal {
    /**
     * @notice allows a user to create a proposal to create a license to use IP Assets / IP Orgs
     * @param _proposal An IPFS URI proposal document
     * @param _assets_orgs An array of IP Asset / IP Org IDs
     * @dev
     */
    function createProposal(
        string calldata _proposal,
        address[] calldata _assets_orgs
    ) external;

    /**
     * @notice allows an ORG/Asset Owner to vote on wether to pass/remove a proposal
     * @param uri The IPFS URI, amendment suggested by the ORG/Asset Owner
     * @param _proposal The proposal ID
     * @param _vote The vote (true/false)
     * @dev
     */
    function orgAssetVote(
        string memory uri,
        uint256 _proposal,
        bool _vote
    ) external;

    /**
     * @notice Allows the proposal creator to end the proposal and accept/deny the proposal
     * @param _proposal The proposalID to end
     * @param accept_deny Status to accept or deny the proposal
     */
    function proposalEnd(uint256 _proposal, bool accept_deny) external;
}
