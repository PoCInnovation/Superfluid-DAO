import { Link } from "react-router-dom";

const NavBar = () => {
  return (
    <div className="flex items-center">
      <Link to="/">
        <img src="/logo.png" alt="logo" className="w-20 h-20" />
      </Link>
      <div className="flex-row-reverse flex gap-20 items-center w-full">
        <button className="btn btn-outline btn-success rounded-full">
          Connect Wallet
        </button>
        <p className="text-xl">About us</p>
        <Link to="/yours-dao" className="text-xl">
          DAO's
        </Link>
        <p className="text-xl">Explore</p>
      </div>
    </div>
  );
};

export default NavBar;
