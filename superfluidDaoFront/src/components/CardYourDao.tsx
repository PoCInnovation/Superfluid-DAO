type Props = {
  name: string;
  description: string;
}

const CardYourDao = (props: Props) => {
  return (
    <div className="flex bg-stone-300 flex-col border-2 border-green-500 rounded-lg p-5 gap-5">
      <h1 className="text-left text-black text-4xl font-bold">{props.name}</h1>
      <p className="text-left text-black text-xl max-w-4xl ">{props.description}</p>
    </div>
  );
};

export default CardYourDao;
