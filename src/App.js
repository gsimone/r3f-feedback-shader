import React, { Suspense } from "react";
import { Canvas } from "react-three-fiber";
import { OrbitControls } from "drei";
import Effects from "./Effects";
import Scene from "./Scene";

function App() {
  return (
    <Canvas
      shadowMap
      colorManagement
      camera={{ position: [0, 0, 5], far: 50 }}
      style={{
        background: "#121212",
      }}
      orthographic
      concurrent
    >
      <Scene />
      <Effects />
    </Canvas>
  );
}

export default App;
