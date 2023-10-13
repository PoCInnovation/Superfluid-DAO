import { Link } from "react-router-dom";
import CardExplore from "../components/CardExplore";

const Explore = () => {
  return (
    <>
      <div className="flex flex-col gap-5 pt-24">
        <h1 className="text-left text-6xl font-bold">Explore the DAO World</h1>
        <p className="text-left text-2xl max-w-4xl">
        Build your DAO, explore communities, and find inspiration for your project all in one place.
        </p>
      </div>
      <div className="flex gap-10 pt-10">
        <Link to="/create-dao">
          <CardExplore
            name={"Create your DAO"}
            description={
              "Create your dao and invite friends"
            }
          />
        </Link>
        <Link to="/your-daos">
          <CardExplore
            name={"Your DAO's"}
            description={
              "Check your daos"
            }
          />
        </Link>
        <Link to="/dao-doc">
          <CardExplore
            name={"What is a DAO ?"}
            description={
              "Documentation for DAO"
            }
          />
        </Link>
      </div>
    </>
  );
};

export default Explore;
