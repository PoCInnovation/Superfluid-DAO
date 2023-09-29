import { Link } from "react-router-dom";

type Props = {
  name: string;
  description: string;
  link: string;
};

const CardDaos = (props: Props) => {
    return (
        <div className="card w-96 bg-base-100 shadow-xl">
            <figure className="px-10 pt-10">
              <img src="/images/stock/photo-1606107557195-0e29a4b5b4aa.jpg" alt="Shoes" className="rounded-xl" />
            </figure>
            <div className="card-body items-center text-center">
              <h2 className="card-title">{props.name}</h2>
              <p>{props.description}</p>
              <div className="card-actions">
                <button className="btn btn-primary">Buy Now</button>
              </div>
            </div>
        </div>
    );
};

export default CardDaos;