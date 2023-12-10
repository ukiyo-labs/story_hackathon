// SPDX-License-Identifier: MIT

pragma solidity 0.8.23;

// Story Protocol
import {IIPOrg} from "@story/interfaces/ip-org/IIPOrg.sol";
import {IRegistrationModule} from "@story/interfaces/modules/registration/IRegistrationModule.sol";
// Internal Interfaces
import "./interface/ILicenseProposal.sol";

error LicenseProposal__InvalidProposalOwner();
error LicenseProposal__InvalidAssetOwner();
error LicenseProposal__ProposalEnded();

contract LicenseProposal is ILicenseProposal {
    //-----------------------------------------------------------------
    // State Variables
    //-----------------------------------------------------------------
    mapping(uint256 => Proposal) public proposals;
    uint256 public proposalCount;
    IRegistrationModule public immutable REGISTRATION_MODULE;

    //-----------------------------------------------------------------
    // Constructor
    //-----------------------------------------------------------------
    constructor(address _registrationModule) {
        REGISTRATION_MODULE = IRegistrationModule(_registrationModule);
    }

    //-----------------------------------------------------------------
    // External Functions
    //-----------------------------------------------------------------
    function createProposal(
        string calldata _proposal,
        uint[] calldata _asset_ids,
        uint _endTime
    ) external {
        // @todo revisar si los IPAssets tienen una licencia asociada
        // @todo si la licencia es recíproca, debería de fallar
        proposalCount++;
        uint length = _asset_ids.length;
        ORG_ASSET_VOTE[] memory votes = new ORG_ASSET_VOTE[](length);
        for (uint i = 0; i < length; i++) {
            votes[i] = ORG_ASSET_VOTE.PENDING;
        }
        if (_endTime > block.timestamp) {
            _endTime = block.timestamp + 30 days;
        }
        proposals[proposalCount] = Proposal({
            proposalID: proposalCount,
            endTime: _endTime,
            creator: msg.sender,
            proposal: _proposal,
            asset_ids: _asset_ids,
            votes: votes,
            over: false,
            accepted: false
        });

        emit CreatedProposal(proposalCount, msg.sender, _proposal, _asset_ids);
    }

    function orgAssetVote(
        string calldata _uri,
        uint256 _proposal,
        uint256 index_id,
        bool _vote
    ) external {
        Proposal storage proposal = proposals[_proposal];
        if (proposal.endTime < block.timestamp || proposal.over)
            revert LicenseProposal__ProposalEnded();
        uint asset_id = proposal.asset_ids[index_id];
        address owner = REGISTRATION_MODULE.ownerOf(asset_id);
        if (owner != msg.sender) revert LicenseProposal__InvalidAssetOwner();
        if (bytes(_uri).length > 0) {
            emit AmmendmentAdded(_proposal, asset_id, owner, _uri);
            proposal.proposal = _uri;
        }
        proposal.votes[index_id] = _vote
            ? ORG_ASSET_VOTE.APPROVED
            : ORG_ASSET_VOTE.DENIED;
        emit VotedOnProposal(_proposal, asset_id, proposal.votes[index_id]);
        //@todo if DENIED, end proposal
        _endProposal(_proposal, _vote);
    }

    function endProposal(uint256 _proposal, bool accept_deny) external {
        Proposal storage proposal = proposals[_proposal];
        if (proposal.endTime > block.timestamp || proposal.over)
            revert LicenseProposal__ProposalEnded();
        if (proposal.creator != msg.sender)
            revert LicenseProposal__InvalidProposalOwner();
        for (uint i = 0; i < proposal.votes.length; i++) {
            if (proposal.votes[i] == ORG_ASSET_VOTE.DENIED) {
                accept_deny = false;
                break;
            }
        }
        _endProposal(_proposal, accept_deny);
    }

    //-----------------------------------------------------------------
    // Private Functions
    //-----------------------------------------------------------------
    function _endProposal(uint256 _proposal, bool accept_deny) private {
        Proposal storage proposal = proposals[_proposal];
        proposal.accepted = accept_deny;
        if (accept_deny) {
            //@todo create license
            emit ProposalAccepted(_proposal);
        } else {
            emit ProposalDenied(_proposal);
        }
        proposal.over = true;
    }

    function createLicenses(uint256 proposal) private {
        //1. Create IPOrg
        //2. Create Assets for IPOrg and make them match the proposal Assets
        //3. Create Licenses for IPOrg
    }

    //-----------------------------------------------------------------
    // External VIEW Functions
    //-----------------------------------------------------------------
    function voteStatus(
        uint256 _proposal
    )
        external
        view
        returns (uint[] memory asset_ids, ORG_ASSET_VOTE[] memory votes)
    {
        Proposal storage proposal = proposals[_proposal];
        asset_ids = proposal.asset_ids;
        votes = proposal.votes;
    }

    function orgAssetsProposals(
        uint _asset_id,
        bool _is_pending
    ) external view returns (uint[] memory) {
        uint length = proposalCount + 1;
        uint[] memory asset_proposals = new uint[](length);
        uint count = 0;
        for (uint i = 1; i < length; i++) {
            Proposal storage proposal = proposals[i];
            uint index = orgAssetProposalIndex(i, _asset_id);
            if (index == type(uint256).max) continue;
            if (
                !proposal.over &&
                _is_pending &&
                proposal.votes[index] != ORG_ASSET_VOTE.PENDING
            ) continue;
            asset_proposals[count] = i;
            count++;
        }
        return asset_proposals;
    }

    function orgAssetProposalIndex(
        uint256 _proposal,
        uint256 _asset_id
    ) public view returns (uint256) {
        Proposal storage proposal = proposals[_proposal];
        uint length = proposal.asset_ids.length;
        for (uint i = 0; i < length; i++) {
            if (proposal.asset_ids[i] == _asset_id) {
                return i;
            }
        }
        return type(uint256).max;
    }

    function userProposals(
        address _user,
        bool isPending
    ) external view returns (uint[] memory) {
        uint length = proposalCount + 1;
        uint[] memory user_proposals = new uint[](length);
        uint count = 0;
        for (uint i = 1; i < length; i++) {
            Proposal storage proposal = proposals[i];
            if (proposal.creator != _user) continue;
            if (isPending && proposal.over) continue;
            user_proposals[count] = i;
            count++;
        }
        return user_proposals;
    }
}
