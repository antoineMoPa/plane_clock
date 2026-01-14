uniform sampler2D tDiffuse;
uniform float time;
varying vec2 vUv;

void main() {
    // EXPERIMENT WITH THIS SHADER!
    // vUv is the texture coordinate (0.0 to 1.0)
    // tDiffuse is the rendered scene
    // time is animated

    float delta = 0.003;

    vec4 base = texture2D(tDiffuse, vUv);

    // edge detection
    vec4 c1 = texture2D(tDiffuse, vUv + vec2(delta, 0.0));
    vec4 c2 = texture2D(tDiffuse, vUv + vec2(-delta, 0.0));
    vec4 c3 = texture2D(tDiffuse, vUv + vec2(0.0, delta));
    vec4 c4 = texture2D(tDiffuse, vUv + vec2(0.0, -delta));

    vec4 color = (c2 - c1) + (c4 - c3) + base * 0.4;
    vec4 neon_green = vec4(0.2, 1.0, 0.3, 1.0);

    color *= neon_green;

    // vignette
    color += 0.3 * pow(length(vUv - vec2(0.5)), 2.0) * neon_green;

    // pixelate
    float pixelator = floor(mod(vUv.y * 300.0,2.0)) * floor(mod(vUv.x * 300.0, 2.0));
    color *= 0.2 + pixelator;

    color *= 1.0 + 0.2 * cos(vUv.y * 100.0 + time * 6.2832);

    color.a = 1.0;

    gl_FragColor = color;
}
