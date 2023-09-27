import { Link } from "react-router-dom";

type Props = {
  name: string;
  description: string;
};

const CardYourDao = (props: Props) => {
  return (
    <Link to="/dashboard">
      <div className="card card-side bg-base-0 shadow-xs">
        <div className="bg-gray-800 p-6 rounded-lg shadow-lg flex bg-gray-400">
          <img
            src="/images/stock/photo-1635805737707-575885ab0820.jpg"
            alt="Dao1"
            className="w-24 h-24 object-cover rounded-full mr-4"
          />
          <div>
            <h1 className="text-3xl font-bold text-white text-left">{props.name}</h1>
            <p className="text-gray-300 text-sm mt-2 text-justify">{props.description}</p>
          </div>
        </div>
      </div>
    </Link>
  );
};

export default CardYourDao;
