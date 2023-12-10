export default function CreateProposalForm() {
  return (
    <div className="container w-full">
      <div className="form-control max-w-xs">
        <label className="label">
          <span className="label-text text-3xl font-anton">Proposal Title</span>
        </label>
        <input
          type="text"
          placeholder="My proposal..."
          className="input input-bordered"
        />
        <label className="label">
          <span className="label-text-alt">Keep it short and sweet</span>
        </label>
      </div>
      <div>
        <label className="label">
          <span className="label-text text-3xl font-anton">
            Proposal Description
          </span>
        </label>
        <textarea
          placeholder="My proposal is about..."
          className="textarea textarea-bordered h-24 w-full"
        />
      </div>
      <div>
        <label className="label">
          <span className="label-text">Licensing terms required</span>
        </label>
        <div>
          <label className="label">
            <span className="label-text">Derivatives</span>
            <input type="checkbox" className="toggle" name="license" />
          </label>
          <label className="label">
            <span className="label-text">Atrributions</span>
            <input type="checkbox" className="toggle" name="license" />
          </label>
        </div>
        <div>
          <label className="label">
            <span className="label-text text-3xl text-white font-anton">
              Distribution Channels
            </span>
          </label>
          <div className="px-4">
            <label className="label">
              <span className="label-text">Television</span>
              <input type="checkbox" className="checkbox" name="license" />
            </label>
            <label className="label">
              <span className="label-text">Video</span>
              <input type="checkbox" className="checkbox" name="license" />
            </label>
            <label className="label">
              <span className="label-text">Books</span>
              <input type="checkbox" className="checkbox" name="license" />
            </label>
            <label className="label">
              <span className="label-text">Email</span>
              <input type="checkbox" className="checkbox" name="license" />
            </label>
          </div>
        </div>
        <div className="flex flex-row items-center justify-center">
          <button className="btn btn-primary">Create Proposal</button>
        </div>
      </div>
    </div>
  );
}
