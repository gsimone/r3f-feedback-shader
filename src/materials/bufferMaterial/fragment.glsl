uniform float time;
uniform vec2 resolution;
uniform sampler2D bufferTexture;

varying vec3 vNormal;
varying vec2 vUv;

void main()	{
    vec3 color = texture2D(bufferTexture, vUv).rgb;
    
    gl_FragColor = vec4(vUv, 1., 1.);
    gl_FragColor.r += 0.01;
}
