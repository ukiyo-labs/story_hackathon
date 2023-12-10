"use client";
import { IoIosRemoveCircle } from "react-icons/io";
import useIpAssetData from "@/hook/useIpAsset";

export default function AssetList() {
  return (
    <table className="table">
      <thead>
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Profile</th>
          <th>License</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <AssetItem
          id={201}
          name="Asset 1"
          profile="Profile 1"
          license="License 1"
        />
        <AssetItem
          id={202}
          name="Asset 2"
          profile="Profile 2"
          license="License 2"
        />
        <AssetItem
          id={203}
          name="Asset 3"
          profile="Profile 3"
          license="License 3"
        />
      </tbody>
    </table>
  );
}
function AssetItem(props: {
  id: number;
  name: string;
  profile: string;
  license: string;
}) {
  const { ipAssetData } = useIpAssetData(props.id);

  console.log({ ipAssetData, id: props.id });
  return (
    <tr>
      <td>{props.id}</td>
      <td>{ipAssetData?.asset.name || ""}</td>
      <td>
        <a
          href={`https://sp-explorer.vercel.app/ipa/${ipAssetData?.asset.ipOrgId}/${props.id}`}
          target="_blank"
          rel="noopenner nonreferrer"
        >
          <div className="w-10 h-10">
            <img
              src={ipAssetData?.allMedia?.image}
              alt={`ip-asset-media-${props.id}`}
              className="max-w-[40px] max-h-[40px]"
            />
          </div>
        </a>
      </td>
      <td>{ipAssetData?.asset?.licenseId ?? "Unlicensed"}</td>
      <td>
        <button className="btn btn-primary">
          <IoIosRemoveCircle />
        </button>
      </td>
    </tr>
  );
}
