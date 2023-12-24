// SPClient/storyProtocolClient.js (or .ts)

import { StoryClient } from '@story-protocol/core-sdk';
import { createWalletClient, custom } from 'viem';
import { sepolia } from 'viem/chains';

// ... other code ...

async function initializeClients() {
  // ... initialization code ...
  const readonlyClient = StoryClient.newReadOnlyClient({});
  const client = StoryClient.newClient({ account });

  return { readonlyClient, client };
}

export const clientsPromise = initializeClients();
