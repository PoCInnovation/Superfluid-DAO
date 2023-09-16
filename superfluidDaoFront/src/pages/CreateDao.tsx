const CreateDao = () => {
  return (
    <>
      <div className="flex flex-row place-content-around pt-44">
        <div className="flex flex-col gap-5">
          <h1 className="text-left text-6xl font-bold">Build your DAO</h1>
          <p className="text-left text-2xl max-w-4xl">
            Need ideas ? Or just curious ? Discover what your neighbors do.
            Unlock the potential of decentralized innovation by creating a DAO
            (Decentralized Autonomous Organization) today.
          </p>
          <p className="text-left text-2xl max-w-4xl">
            With DAOs, you empower communities, ensure transparency through
            blockchain technology, and drive efficiency with smart contracts.
            Join the movement, shape the future, and pioneer a new era of
            decentralized governance and innovation. Start your DAO journey
            today!
          </p>
        </div>
        <div className="flex-col flex gap-10">
          <h1 className="text-left text-6xl font-bold">Create your dao</h1>
          <div className="flex border flex-col p-12 border-green-500 rounded-xl gap-10">
            <input
              type="text"
              placeholder="Name"
              className="input input-bordered w-full max-w-xs"
            />
            <input
              type="text"
              placeholder="Description"
              className="input input-bordered w-full max-w-xs"
            />
            <input
              type="text"
              placeholder="Email"
              className="input input-bordered w-full max-w-xs"
            />
          </div>
          <button className="btn btn-outline btn-success btn-lg rounded-full">
            Create
          </button>
        </div>
      </div>
    </>
  );
};

export default CreateDao;
