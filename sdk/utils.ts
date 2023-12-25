import { createWalletClient, custom } from 'viem'
import { sepolia } from 'viem/chains'

const walletClient = createWalletClient({
  chain: sepolia,
  transport: custom(window.ethereum)
})

// Retrieve the first account for eth_requestAccounts method
const account = await walletClient.requestAddresses()[0]