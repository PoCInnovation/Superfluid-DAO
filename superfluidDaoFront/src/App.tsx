import "./App.css";

export const NavBar = () => {
  return (
    <div className="flex items-center">
      <img src="/logo.png" alt="logo" className="w-20 h-20" />
      <div className="flex-row-reverse flex gap-20 items-center w-full">
        <button className="btn btn-outline btn-success rounded-full">
          Connect Wallet
        </button>
        <p className="text-xl">About us</p>
        <p className="text-xl">DAOs</p>
        <p className="text-xl">Explore</p>
      </div>
    </div>
  );
};

export const LandingComponent = () => {
  return (
    <div className="flex flex-row items-center justify-center pt-40">
      <div className="flex place-items-start flex-col gap-10">
        <h1 className="text-6xl font-bold">Landing Page</h1>
        <p className="text-left text-2xl max-w-4xl">
          Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
          eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
          minim veniam, quis nostrud exercitation ullamco laboris nisi ut
          aliquip ex ea commodo consequat. Duis aute irure dolor in
          reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
          pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
          culpa qui officia deserunt mollit anim id est laborum.
        </p>
        <div className="flex gap-7">
          <button className="btn btn-outline btn-success rounded-full">
            Connect Wallet
          </button>
          <button className="btn btn-outline btn-success rounded-full">
            What is a DAO?
          </button>
        </div>
      </div>
      <img src="/landing.png" alt="landing" className="w-1/2 h-1/2" />
    </div>
  );
};

function App() {
  return (
    <>
      <NavBar />
      <LandingComponent />
    </>
  );
}

export default App;
