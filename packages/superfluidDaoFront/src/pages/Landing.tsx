const LandingComponent = () => {
  return (
    <div className="flex flex-row justify-center items-center pt-40">
      <div className="flex place-items-start flex-col gap-10">
        <h1 className="text-6xl font-bold">SuperFluid DAO</h1>
        <p className="text-justify text-lg max-w-4xl mb-5 mr-5">
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
      <img src="https://cdn-icons-png.flaticon.com/512/8100/8100284.png" alt="landing" className="w-1/2 h-1/2" />
    </div>
  );
};

export default LandingComponent;
