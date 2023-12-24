"use client";

import React, { useState } from 'react';
import { useSignMessage } from 'wagmi';

export default function CreateProposalForm() {
  const [title, setTitle] = useState('');
  const [description, setDescription] = useState('');
  const [derivatives, setDerivatives] = useState(false);
  const [attributions, setAttributions] = useState(false);
  const [distributionChannels, setDistributionChannels] = useState({
    television: false,
    video: false,
    books: false,
    email: false,
  });

  const { signMessage } = useSignMessage();

  const handleCheckboxChange = (event) => {
    const { name, checked } = event.target;
    if (['television', 'video', 'books', 'email'].includes(name)) {
      setDistributionChannels(prev => ({ ...prev, [name]: checked }));
    } else {
      name === 'derivatives' ? setDerivatives(checked) : setAttributions(checked);
    }
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      const message = `Title: ${title}, Description: ${description}, Derivatives: ${derivatives}, Attributions: ${attributions}, Distribution Channels: ${JSON.stringify(distributionChannels)}`;
      const { data: signedMessage } = await signMessage({ message });
      console.log('Signed Message:', signedMessage);
      // Additional logic after signing
    } catch (error) {
      console.error('Error signing message:', error);
    }
  };

  return (
    <div className="container w-full">
      <form onSubmit={handleSubmit}>
        <div className="form-control max-w-xs">
          <label className="label">
            <span className="label-text text-3xl font-anton">Proposal Title</span>
          </label>
          <input
            type="text"
            placeholder="My proposal..."
            className="input input-bordered"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
          />
        </div>
        <div>
          <label className="label">
            <span className="label-text text-3xl font-anton">Proposal Description</span>
          </label>
          <textarea
            placeholder="My proposal is about..."
            className="textarea textarea-bordered h-24 w-full"
            value={description}
            onChange={(e) => setDescription(e.target.value)}
          />
        </div>
        <div>
          <label className="label">
            <span className="label-text">Licensing terms required</span>
          </label>
          <div>
            <label className="label">
              <span className="label-text">Derivatives</span>
              <input type="checkbox" className="toggle" name="derivatives" checked={derivatives} onChange={handleCheckboxChange} />
            </label>
            <label className="label">
              <span className="label-text">Attributions</span>
              <input type="checkbox" className="toggle" name="attributions" checked={attributions} onChange={handleCheckboxChange} />
            </label>
          </div>
          <div>
            <label className="label">
              <span className="label-text text-3xl text-white font-anton">
                Distribution Channels
              </span>
            </label>
            <div className="px-4">
              {/* Repeat this pattern for each distribution channel */}
              <label className="label">
                <span className="label-text">Television</span>
                <input type="checkbox" className="checkbox" name="television" checked={distributionChannels.television} onChange={handleCheckboxChange} />
              </label>
              {/* ... Other distribution channels ... */}
            </div>
          </div>
        </div>
        <div className="flex flex-row items-center justify-center">
          <button className="btn btn-primary" type="submit">Create Proposal</button>
        </div>
      </form>
    </div>
  );
}
