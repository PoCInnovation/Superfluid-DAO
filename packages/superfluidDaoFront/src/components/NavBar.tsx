import { Link } from "react-router-dom";
import logo from '../assets/logo.svg'
import Profile from "./buttons/ConnectWallet";
import { WagmiConfig, createConfig, mainnet } from 'wagmi'
import { createPublicClient, http } from 'viem'
 
const config = createConfig({
  autoConnect: true,
  publicClient: createPublicClient({
    chain: mainnet,
    transport: http()
  }),
})

const NavBar = () => {
  return (
    <div className="flex items-center">
      <Link to="/">
        <img src={logo} alt="logo" className="w-25 h-20" />
      </Link>
      <div className="flex-grow flex justify-end items-center space-x-20">
        <Link to="/about-us" className="text-xl hover:underline">
          About Us
        </Link>
        <Link to="/yours-dao" className="text-xl hover:underline">
          DAO's
        </Link>
        <Link to="/yours-dao" className="text-xl hover:underline">
          Explore
        </Link>
        <WagmiConfig config={config}>
          <Profile />
        </WagmiConfig>
      </div>
    </div>
  );
};

export default NavBar;
