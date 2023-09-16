import "./App.css";
import NavBar from "./components/NavBar";
import LandingComponent from "./pages/Landing";
import CreateDao from "./pages/CreateDao";
import YoursDao from "./pages/YoursDao";
import Dashboard from "./pages/Dashboard";
import { Routes, Route } from "react-router-dom";

function App() {
  return (
    <>
      <NavBar />
      <Routes>
        <Route path="/" element={<LandingComponent />} />
        <Route path="/create-dao" element={<CreateDao />} />
        <Route path="/yours-dao" element={<YoursDao />} />
        <Route path="/dashboard" element={<Dashboard />} />
      </Routes>
    </>
  );
}

export default App;
