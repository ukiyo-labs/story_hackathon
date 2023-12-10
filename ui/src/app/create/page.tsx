import AssetList from "@/components/create/AssetList";
import CreateProposalForm from "@/components/create/CreateProposalForm";

export default function CreatePage() {
  return (
    <main className="min-h-screen flex flex-col items-center">
      <h1 className="text-6xl py-4 font-anton">Create Proposal</h1>
      <section className="container">
        <h2 className="text-text-primary font-anton label-text text-3xl">
          Assets Requested
        </h2>
        <AssetList editable />
      </section>
      <section className="w-full flex flex-col items-center">
        <CreateProposalForm />
      </section>
    </main>
  );
}
