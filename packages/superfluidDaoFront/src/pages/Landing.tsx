const LandingComponent = () => {
  return (
    <div className="flex flex-row justify-center items-center pt-40">
      <div className="flex place-items-start flex-col gap-10">
        <h1 className="text-6xl font-bold">SuperFluid DAO</h1>
        <p className="text-justify text-lg max-w-4xl mb-5 mr-5">
        Superfluid DAO enables users to create and interact with a DAO where participation is essential. By utilizing the Superfluid protocol, users must actively engage, or they risk losing tokens. This encourages active involvement and participatory governance within the community.
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
