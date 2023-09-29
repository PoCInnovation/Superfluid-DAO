type Props = {
  timeSpan: string;
  description: string;
  owner: string;
};

const CardProposal = (props: Props) => {
  return (
    <div className="flex flex-col gap-5">
      <div className="flex flex-row justify-between">
        <div className="flex flex-col gap-5">
          <h1 className="text-left text-2xl font-bold">{props.owner}</h1>
          <p className="text-left text-2xl max-w-4xl">{props.description}</p>
        </div>
        <div className="flex flex-col gap-5">
          <h1 className="text-left text-2xl font-bold">{props.timeSpan}</h1>
        </div>
      </div>
      <div className="flex flex-row gap-5">
        <button className="btn btn-outline btn-success btn-md rounded-full">
          Approve
        </button>
        <button className="btn btn-outline btn-success btn-md rounded-full">
          Reject
        </button>
      </div>
    </div>
  );
};

export default CardProposal;
