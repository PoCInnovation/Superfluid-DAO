const AboutUs = () => {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="text-center">
          <h1 className="text-4xl font-bold mb-10">Superfluid-DAO team</h1>
          <div className="flex justify-center space-x-4">
            <div className="flex space-x-4">
              <div className="flex flex-col items-center">
                <a href="https://github.com/SloWayyy">
                  <img src="https://avatars.githubusercontent.com/u/91888897?v=4" alt="Mehdi" className="w-28 h-28 rounded-full mb-3" />
                </a>
                <p className="text-lg font-semibold">Mehdi</p>
              </div>
  
              <div className="flex flex-col items-center">
                <a href="https://github.com/1yam">
                  <img src="https://avatars.githubusercontent.com/u/40899431?v=4" alt="Lyam" className="w-28 h-28 rounded-full mb-3" />
                </a>
                <p className="text-lg font-semibold">Lyam</p>
              </div>
  
              <div className="flex flex-col items-center">
                <a href="https://github.com/moonia">
                  <img src="https://avatars.githubusercontent.com/u/99096342?v=4" alt="Mounia" className="w-28 h-28 rounded-full mb-3" />
                </a>
                <p className="text-lg font-semibold">Mounia</p>
              </div>

              <div className="flex flex-col items-center">
                <a href="https://github.com/Doozers">
                  <img src="https://avatars.githubusercontent.com/u/71719097?v=4" alt="Isma" className="w-28 h-28 rounded-full mb-3" />
                </a>
                <p className="text-lg font-semibold">Ismael</p>
              </div>
  
              <div className="flex flex-col items-center">
                <a href="https://github.com/LeTamanoir">
                  <img src="https://avatars.githubusercontent.com/u/51637671?v=4" alt="Martin" className="w-28 h-28 rounded-full mb-3" />
                </a>
                <p className="text-lg font-semibold">Martin</p>
              </div>
            </div>
          </div>
          <p className="mt-12 text-xl">Made with ❤️ by PoC.</p>
        </div>
      </div>
    );
  };
  
  export default AboutUs;
  