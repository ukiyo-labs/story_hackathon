"use client";

import { type IPAsset, StoryClient } from "@story-protocol/core-sdk";
import { useState, useEffect, useCallback } from "react";

export default function useIpAssetData(id: number) {
  const [ipAssetData, setIpAssetData] = useState<{
    asset: IPAsset & { licenseId?: number };
    allMedia: any;
  } | null>(null);

  const getIpAssetData = useCallback(async () => {
    const readClient = StoryClient.newReadOnlyClient({});
    const { ipAsset } = await readClient.ipAsset.get({
      ipAssetId: id.toString(),
    });
    const moreData = await fetch(ipAsset.mediaUrl).then((res) => res.json());
    setIpAssetData({ asset: ipAsset, allMedia: moreData });
  }, [id, setIpAssetData]);

  useEffect(() => {
    if (isNaN(id)) return;
    getIpAssetData();
  }, [getIpAssetData, id]);

  return { ipAssetData };
}
