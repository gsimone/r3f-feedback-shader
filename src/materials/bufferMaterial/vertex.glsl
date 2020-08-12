uniform float time;
uniform vec2 resolution;

varying vec2 vUv;

#pragma glslify: snoise3 = require(glsl-noise/simplex/3d)

void main()	{
    vUv = uv;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.);
}
