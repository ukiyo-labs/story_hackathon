// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface ILicenseProposal {
    enum ORG_ASSET_VOTE {
        PENDING,
        APPROVED,
        DENIED
    }

    struct Proposal {
        uint256 proposalID;
        address creator;
        string proposal;
        address[] assets_orgs;
        ORG_ASSET_VOTE[] votes;
    }

    //-----------------------------------------------------------------
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
     * @param index_id The index of the asset/org in the proposal (Gas savings)
     * @param _vote The vote (true/false)
     * @dev
     */
    function orgAssetVote(
        string memory uri,
        uint256 _proposal,
        uint256 index_id,
        bool _vote
    ) external;

    /**
     * @notice Allows the proposal creator to end the proposal and accept/deny the proposal
     * @param _proposal The proposalID to end
     * @param accept_deny Status to accept or deny the proposal
     */
    function proposalEnd(uint256 _proposal, bool accept_deny) external;

    /**
     *
     * @param _proposal The proposal ID
     * @return assets_orgs The orgs and assets that are being voted on
     * @return votes Each org/asset's vote
     */
    function voteStatus(
        uint256 _proposal
    )
        external
        view
        returns (address[] memory assets_orgs, ORG_ASSET_VOTE[] memory votes);

    /**
     * @notice returns all the proposal ID's for a given org/asset
     * @param _org_asset ]The org/asset ID
     * @dev to be called only by UI
     */
    function orgAssetsProposals(
        address _org_asset
    ) external view returns (uint256[] memory proposals);

    //-----------------------------------------------------------------
    event CreatedProposal(
        uint256 indexed proposalID,
        address indexed creator,
        string proposal,
        address[] assets_orgs
    );

    event VotedOnProposal(
        uint256 indexed proposalID,
        address indexed voter,
        ORG_ASSET_VOTE vote
    );

    event ProposalEnded(
        uint256 indexed proposalID,
        address indexed creator,
        bool accept_deny_status
    );
    //-----------------------------------------------------------------
}
