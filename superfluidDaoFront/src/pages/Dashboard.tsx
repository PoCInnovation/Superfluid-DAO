import CardYourDao from "../components/CardYourDao";
import CardProposal from "../components/CardProposal";

const Dashboard = () => {
  return (
    <div className="flex flex-col gap-5 pt-12">
      <CardYourDao
        name={"My dao1"}
        description={
          "Lorem ipsum dolor sitamco laboris nisi ut aliquip ex ea commodo consequat."
        }
      />
      <div className="flex flex-row place-content-around min-w-full pt-12">
        <div className="flex-col flex min-w-[50%] gap-5">
          <h1 className="text-left text-4xl font-bold">All Proposals</h1>
          <div className="flex border flex-col p-12 border-white rounded-xl gap-5">
            <CardProposal
              timeSpan={"1 week"}
              description={
                "Lorem ipsum dolor sitamco laboris nisi ut aliquip ex ea commodo consequat."
              }
              owner={"0x1234..."}
            />
            <div className="divider" />
            <CardProposal
              timeSpan={"1 week"}
              description={
                "Lorem ipsum dolor sitamco laboris nisi ut aliquip ex ea commodo consequat."
              }
              owner={"0x1234..."}
            />
          </div>
        </div>
        <div className="flex-col flex gap-5">
          <h1 className="text-left text-4xl font-bold">Make Proposals</h1>
          <div className="flex border flex-col p-12 border-white rounded-xl gap-10">
            <input
              type="text"
              placeholder="Description"
              className="input input-bordered w-full max-w-xs"
            />
            <input
              type="text"
              placeholder="Time-span"
              className="input input-bordered w-full max-w-xs"
            />
          </div>
          <button className="btn btn-outline btn-success btn-lg rounded-full">
            Create
          </button>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
