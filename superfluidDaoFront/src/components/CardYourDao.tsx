const CardYourDao = (props: { name: string; description: string }) => {
  return (
    <div className="flex max-h-40 bg-white flex-col border rounded-lg w-1/2 p-5 gap-5">
      <h1 className="text-left text-black text-4xl font-bold">{props.name}</h1>
      <p className="text-left text-black text-xl max-w-4xl">{props.description}</p>
    </div>
  );
};

export default CardYourDao;
