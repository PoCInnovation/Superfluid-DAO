import { Link } from "react-router-dom";

type Props = {
  name: string;
  description: string;
};

const CardYourDao = (props: Props) => {
  return (
    <Link to="/dashboard">
      <div className="bg-gray-800 p-6 rounded-lg shadow-lg">
        <h1 className="text-3xl font-bold text-white">{props.name}</h1>
        <p className="text-gray-300 text-lg mt-3">{props.description}</p>
      </div>
    </Link>
  );
};

export default CardYourDao;
