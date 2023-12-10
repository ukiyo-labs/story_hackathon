import AssetList from "@/components/create/AssetList";
import CreateProposalForm from "@/components/create/CreateProposalForm";

export default function CreatePage() {
  return (
    <main className="min-h-screen flex flex-col items-center">
      <h1 className="text-3xl py-4">Create Proposal</h1>
      <div>
        <AssetList />
      </div>
      <section className="w-full flex flex-col items-center">
        <CreateProposalForm />
      </section>
    </main>
  );
}
