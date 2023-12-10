import AssetList from "@/components/create/AssetList";

export default function ProposalPage() {
  return (
    <div>
      <h1>Proposal Page</h1>
      <h2>Proposal Title</h2>
      <p>Proposal Description</p>
      <h3>Assets Requested</h3>
      <AssetList editable={false} status={[1, 2, 3]} />
    </div>
  );
}
