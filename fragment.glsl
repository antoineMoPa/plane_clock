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
    vec4 c1 = texture2D(tDiffuse, vUv + vec2(delta, 0.0));
    vec4 c2 = texture2D(tDiffuse, vUv + vec2(-delta, 0.0));
    vec4 c3 = texture2D(tDiffuse, vUv + vec2(0.0, delta));
    vec4 c4 = texture2D(tDiffuse, vUv + vec2(0.0, -delta));

    vec4 color = (c2 - c1) + (c4 - c3) + base * 0.5;

    color *= vec4(0.2, 1.0, 0.3, 1.0);

    float pixelator = floor(mod(vUv.y * 200.0,2.0)) * floor(mod(vUv.x * 200.0, 2.0));

    color *= 0.5 + pixelator;
    //color += 0.1 * vec4(0.2, 1.0, 0.3, 1.0) * pixelator;

    color.a = 1.0;

    gl_FragColor = color;
}
