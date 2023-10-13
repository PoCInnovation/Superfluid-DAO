import "./App.css";
import NavBar from "./components/NavBar";
import LandingComponent from "./pages/Landing";
import CreateDao from "./pages/CreateDao";
import YourDaos from "./pages/YourDaos";
import Dashboard from "./pages/Dashboard";
import AboutUs from "./pages/AboutUs";
import Explore from "./pages/Explore";
import { Routes, Route } from "react-router-dom";

const App = () => {
  return (
    <div className="app-container">
      <NavBar />
      <Routes>
        <Route path="/" element={<LandingComponent />} />
        <Route path="/create-dao" element={<CreateDao />} />
        <Route path="/your-daos" element={<YourDaos />} />
        <Route path="/about-us" element={<AboutUs />} />
        <Route path="/dashboard" element={<Dashboard />} />
        <Route path="/explore" element={<Explore />} />
      </Routes>
    </div>
  );
};

export default App;

