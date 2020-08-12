import { extend } from "react-three-fiber";
import { shaderMaterial } from "drei";

import vertex from "./vertex.glsl";
import fragment from "./fragment.glsl";

const BufferMaterial = shaderMaterial({ time: 0, bufferTexture: null }, vertex, fragment);

extend({ BufferMaterial });
