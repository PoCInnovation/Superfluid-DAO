import "./App.css";
import NavBar from "./components/NavBar";
import LandingComponent from "./pages/Landing";
import CreateDao from "./pages/CreateDao";
import YoursDao from "./pages/YoursDao";
import Dashboard from "./pages/Dashboard";
import AboutUs from "./pages/AboutUs";
import { Routes, Route } from "react-router-dom";

const App = () => {
  return (
    <div className="app-container">
      <NavBar />
      <Routes>
        <Route path="/" element={<LandingComponent />} />
        <Route path="/create-dao" element={<CreateDao />} />
        <Route path="/yours-dao" element={<YoursDao />} />
        <Route path="/about-us" element={<AboutUs />} />
        <Route path="/dashboard" element={<Dashboard />} />
        <Route path="/explore" element={<Dashboard />} />
      </Routes>
    </div>
  );
};

export default App;

