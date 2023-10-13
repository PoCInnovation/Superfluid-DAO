import { Link } from "react-router-dom";

type Props = {
  name: string;
  description: string;
};

const CardYourDao = (props: Props) => {
  return (
    <Link to="/dashboard">
      <div className="card card-side bg-base-0 shadow-xs">
        <div className="p-6 rounded-lg shadow-lg flex bg-gray-300">
          <div className="avatar placeholder">
            <div className="bg-neutral-focus text-neutral-content rounded-full w-24">
              <span className="text-4xl">{props.name.charAt(0)}</span>
            </div>
          </div>
          <div>
            <h1 className="text-3xl ml-4 font-bold text-white text-left">{props.name}</h1>
            <p className="text-gray-600 text-sm ml-4 mt-2 text-justify">{props.description}</p>
          </div>
        </div>
      </div>
    </Link>
  );
};

export default CardYourDao;
