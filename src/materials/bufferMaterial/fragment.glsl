uniform float time;
uniform vec2 resolution;
uniform sampler2D bufferTexture;
uniform vec2 mouse;

varying vec3 vNormal;
varying vec2 vUv;

#define TWO_PI 6.28318530718

vec3 hsb2rgb( in vec3 c ){
    vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0), 6.0)-3.0)-1.0, 0.0, 1.0 );
    rgb = rgb*rgb*(3.0-2.0*rgb);
    return c.z * mix( vec3(1.0), rgb, c.y);
}

vec3 bump3y(vec3 x, vec3 yoffset) {
  vec3 y = vec3(1.,1.,1.) - x * x;
  y = saturate(y-yoffset);
  return y;
}

vec3 spectral_zucconi6(float x) {

  const vec3 c1 = vec3(3.54585104, 2.93225262, 2.41593945);
  const vec3 x1 = vec3(0.69549072, 0.49228336, 0.27699880);
  const vec3 y1 = vec3(0.02312639, 0.15225084, 0.52607955);

  const vec3 c2 = vec3(3.90307140, 3.21182957, 3.96587128);
  const vec3 x2 = vec3(0.11748627, 0.86755042, 0.66077860);
  const vec3 y2 = vec3(0.84897130, 0.88445281, 0.73949448);

  return
  bump3y(c1 * (x - x1), y1) +
  bump3y(c2 * (x - x2), y2);
}

vec3 zucconiPow(float x) {
  vec3 z = spectral_zucconi6(x);
  return vec3(
  pow(z.r, 2.2),
  pow(z.g, 2.2),
  pow(z.b, 2.2)
  );
}

float wave(in float value) {
  return (sin(value) + 1.) * .5;
}

void main()	{
    // vec2 pixel = vUv * resolution.xy;
    vec2 uv = vUv;

    float angle = atan(uv.x - 1., uv.y + 1.);

    float dist = length(uv + vec2(-0.5));

    float d = dist
        + wave(angle * .25 + time) * .25 * sin(time * .5)
        + wave(angle * .5 + time) * .5 * sin(time * .25);

    float luma = wave(
        (d * 20.) - sin(time) * 5.) * 0.5;

    // vec3 col = vec3(d);
    vec3 col = vec3(
        spectral_zucconi6(
        abs(-1. + abs(mod(luma + uv.y * 2. + d + 0. + sin(time) * 0.25, 1.)))
        )
    );

    vec4 col_ = texture2D(bufferTexture, vec2(uv.x * 1., uv.y * -1.));

    col += (col_.rgb) * 0.25;

    
    gl_FragColor = clamp(vec4(col,1.0), vec4(0.), vec4(1.));

}
