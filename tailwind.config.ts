import type { Config } from 'tailwindcss';

const config: Config = {
  content: [
    './app/create/**/*.{js,ts,jsx,tsx,mdx}',
    './app/components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/proposal/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      backgroundImage: {
        'gradient-radial': 'radial-gradient(var(--tw-gradient-stops))',
        'gradient-conic':
          'conic-gradient(from 180deg at 50% 50%, var(--tw-gradient-stops))',
      },
      fontFamily: {
        inter: ["var(--font-inter)"],
        anton: ["var(--font-anton)"],
      },
    },
  },
  plugins: [require("daisyui")],
  daisyui: true, // Include base styles
};

export default config;
