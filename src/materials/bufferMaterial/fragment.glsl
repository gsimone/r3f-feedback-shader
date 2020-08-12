uniform float time;
uniform vec2 resolution;
uniform sampler2D bufferTexture;
uniform vec2 mouse;

varying vec3 vNormal;
varying vec2 vUv;

void main()	{

    vec2 pixel = vUv * resolution.xy;
    
    vec3 color = texture2D(bufferTexture, vUv).rgb;

    gl_FragColor = vec4(color, 1.);

    float dist = distance(pixel, mouse * resolution.xy);

    if (dist < 15.) {
        gl_FragColor.rgb += vec3(.1);
    }
    
}
