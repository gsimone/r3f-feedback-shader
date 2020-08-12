uniform float time;
uniform vec2 resolution;
uniform sampler2D bufferTexture;
uniform vec2 mouse;

varying vec3 vNormal;
varying vec2 vUv;

void main()	{
    float x = resolution.x / resolution.y;
    vec2 uv = vUv * vec2(x, 1.) + vec2((1. - x)/2., 0.);

    vec3 color = texture2D(bufferTexture, vUv).rgb;

    gl_FragColor = vec4(color, 1.);

    vec2 coords = vUv * resolution;

    float dist = distance(vUv, mouse);
    if (dist < .05) {
        gl_FragColor.r += .01;
    }

}
