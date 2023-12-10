"use client";

import { WagmiConfig, createConfig } from "wagmi";
import { sepolia } from "viem/chains";
import {
  ConnectKitProvider,
  ConnectKitButton,
  getDefaultConfig,
} from "connectkit";

const chains = [sepolia];
const projectId = "ccc7abd3f4db8a911499e829c7dcecc9";

const metadata = {
  appName: "- Story Hackathon",
  appDescription:
    "What we do is connect people to IPs to streamline further creations",
  appUrl: "https://streamline-creations.io/",
  appIcon: "https://streamline-creations.io/",
};

const wagmiConfig = createConfig(
  getDefaultConfig({
    chains,
    walletConnectProjectId: projectId,
    ...metadata,
  })
);

export function Providers({ children }: { children: React.ReactNode }) {
  return (
    <WagmiConfig config={wagmiConfig}>
      <ConnectKitProvider
        customTheme={{
          "--ck-connectbutton-background": "#04BF55",
          "--ck-connectbutton-color": "#000000",
          "--ck-connectbutton-hover-background": "#5eead4",
        }}
      >
        {children}
      </ConnectKitProvider>
    </WagmiConfig>
  );
}
