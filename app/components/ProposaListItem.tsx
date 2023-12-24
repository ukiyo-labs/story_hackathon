"use client";

import { useState } from "react";
import { IoMdThumbsDown, IoMdThumbsUp } from "react-icons/io";

export function ProposalListItem(props: {
  proposalId: number;
  title: string;
  votes: number;
}) {
  const [votes, setVotes] = useState(props.votes);

  return (
    <tr>
      <td>{props.proposalId}</td>
      <td>{props.title}</td>
      <td>{votes}</td>
      <td className="flex flex-row items-center gap-2">
        <button
          className="btn btn-outline btn-sm btn-circle btn-success"
          onClick={() => setVotes((v) => v + 1)}
        >
          <IoMdThumbsUp />
        </button>
        <button
          className="btn btn-outline btn-sm btn-circle btn-error"
          onClick={() => setVotes((v) => v - 1)}
        >
          <IoMdThumbsDown />
        </button>
      </td>
    </tr>
  );
}
