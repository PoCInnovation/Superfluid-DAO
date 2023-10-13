type Props = {
  name: string;
  description: string;
};

const CardExplore = (props: Props) => {
  return (
    <div className="card w-96 shadow-xl">
      <div className="p-10 rounded-lg bg-gradient-to-br from-green-400 to-success text-white">
        <h2 className="card-title text-white">{props.name}</h2>
        <p className="text-white">{props.description}</p>
      </div>
    </div>
  );
};

export default CardExplore;
