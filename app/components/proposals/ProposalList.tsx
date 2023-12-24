import { ProposalListItem } from "./ProposaListItem";
export default function ProposalList() {
  return (
    <div className="py-2 w-full container">
      <h2 className="font-anton text-6xl font-bold">Proposal List</h2>
      <table className="table">
        <thead>
          <tr>
            <th>Proposal Id</th>
            <th>Title</th>
            <th>Votes</th>
            <th>Up/Down Vote</th>
          </tr>
        </thead>
        <ProposalListItem
          proposalId={1}
          title="Sailor Moon x Hello Kitty Movie"
          votes={1234}
        />
        <ProposalListItem
          proposalId={2}
          title="Batman v IronMan Multiverse Game"
          votes={902}
        />
        <ProposalListItem
          proposalId={3}
          title="The Last of Us: Colombia"
          votes={700}
        />
        <ProposalListItem
          proposalId={4}
          title="Drake x Michael Jackson AI Album"
          votes={227}
        />
        <ProposalListItem
          proposalId={5}
          title="Solid Snake / Pokémon Crossover Collectible Cards"
          votes={2}
        />
      </table>
    </div>
  );
}
