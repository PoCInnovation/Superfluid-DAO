import CardYourDao from "../components/CardYourDao";

const YoursDao = () => {
  return (
    <>
      <div className="flex flex-col gap-5 pt-24">
        <h1 className="text-left text-6xl font-bold">Yours DAOs</h1>
        <p className="text-left text-2xl max-w-4xl">
          Here you can find all your DAOs, you can manage them as you want !
        </p>
      </div>
      <div className="flex grid-cols-2 grid-rows-2 gap-10 pt-10">
        <CardYourDao
          name={"My dao1"}
          description={
            "Lorem ipsum dolor sitamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla"
          }
        />
        <CardYourDao
          name={"My dao2"}
          description={
            "Lorem ipsum dolor sitamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla"
          }
        />
      </div>

      <div className="flex grid-cols-2 grid-rows-2 gap-10 pt-10">
        <CardYourDao
          name={"My dao1"}
          description={
            "Lorem ipsum dolor sitamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla"
          }
        />
        <CardYourDao
          name={"My dao2"}
          description={
            "Lorem ipsum dolor sitamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla"
          }
        />
      </div>
    </>
  );
};

export default YoursDao;