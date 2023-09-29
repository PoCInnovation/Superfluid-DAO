import { Link } from "react-router-dom";
import logo from './logoo.svg'

const NavBar = () => {
  return (
    <div className="flex items-center">
      <Link to="/">
        <img src={logo} alt="logo" className="w-25 h-20" />
      </Link>
      <div className="flex-row-reverse flex gap-20 items-center w-full">
        <button className="btn btn-outline btn-success rounded-full">
          Connect Wallet
        </button>
        <Link to="/about-us" className="text-xl hover:underline">
          About Us
        </Link>
        <Link to="/yours-dao" className="text-xl hover:underline">
          DAO's
        </Link>
        <Link to="/yours-dao" className="text-xl hover:underline">
          Explore
        </Link>
      </div>
    </div>
  );
};

export default NavBar;
