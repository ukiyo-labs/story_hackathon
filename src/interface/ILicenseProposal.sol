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
        uint256 endTime;
        address creator;
        bool over;
        bool accepted;
        string proposal;
        uint[] asset_ids;
        ORG_ASSET_VOTE[] votes;
    }

    //-----------------------------------------------------------------
    /**
     * @notice allows a user to create a proposal to create a license to use IP Assets / IP Orgs
     * @param _proposal An IPFS URI proposal document
     * @param _asset_ids An array of IP Assets
     * @param _endTime The time at which the proposal will end
     * @dev
     */
    function createProposal(
        string calldata _proposal,
        uint[] calldata _asset_ids,
        uint _endTime
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
        string calldata uri,
        uint256 _proposal,
        uint256 index_id,
        bool _vote
    ) external;

    /**
     * @notice Allows the proposal creator to end the proposal and accept/deny the proposal
     * @param _proposal The proposalID to end
     * @param accept_deny Status to accept or deny the proposal
     * @dev this will be called as soon as any of the assets/orgs deny the proposal
     */
    function endProposal(uint256 _proposal, bool accept_deny) external;

    /**
     *
     * @param _proposal The proposal ID
     * @return asset_ids The orgs and assets that are being voted on
     * @return votes Each org/asset's vote
     */
    function voteStatus(
        uint256 _proposal
    )
        external
        view
        returns (uint[] memory asset_ids, ORG_ASSET_VOTE[] memory votes);

    /**
     * @notice returns all the proposal ID's for a given org/asset
     * @param _asset_id The asset ID
     * @param _is_pending If true, returns all pending proposals, else returns all proposals
     * @dev to be called only by UI
     */
    function orgAssetsProposals(
        uint _asset_id,
        bool _is_pending
    ) external view returns (uint256[] memory proposals);

    /**
     * @notice Return the index of an asset in a proposal asset array
     * @param _asset_id The Id to check the index of
     * @param _proposal The proposal to check for assets
     * @return index The index of the asset in the proposal array
     */
    function orgAssetProposalIndex(
        uint _asset_id,
        uint256 _proposal
    ) external view returns (uint256 index);

    /**
     * @notice fetches all IDs of proposals created by a user
     * @param _user The user's address
     * @param isPending If true, returns all pending proposals, else returns all proposals
     */
    function userProposals(
        address _user,
        bool isPending
    ) external view returns (uint256[] memory proposal_ids);

    //-----------------------------------------------------------------
    event CreatedProposal(
        uint256 indexed proposalID,
        address indexed creator,
        string proposal,
        uint[] asset_ids
    );

    event VotedOnProposal(
        uint256 indexed proposalID,
        uint indexed assetIDVoted,
        ORG_ASSET_VOTE vote
    );

    event ProposalAccepted(uint256 indexed proposalID);
    event ProposalDenied(uint256 indexed proposalID);

    event AmmendmentAdded(
        uint256 indexed proposalID,
        uint256 indexed asset_id,
        address indexed creator,
        string ammendment_uri
    );
    //-----------------------------------------------------------------
}
