import "./App.css";
import NavBar from "./components/NavBar";
import LandingComponent from "./pages/Landing";
import CreateDao from "./pages/CreateDao";
import { Routes, Route } from "react-router-dom";

function App() {
  return (
    <>
      <NavBar />
      <Routes>
        <Route path="/" element={<LandingComponent />} />
        <Route path="/create-dao" element={<CreateDao />} />
      </Routes>
    </>
  );
}

export default App;
