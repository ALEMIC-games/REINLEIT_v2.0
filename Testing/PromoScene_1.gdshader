shader_type canvas_item;

uniform float draw_speed: hint_range(0.0, 1.0) = 0.5;
uniform sampler2D texture_channel0;

// Rotate function
vec2 rotate(vec2 p, float a) {
    return vec2(p.x * cos(a) - p.y * sin(a), p.x * sin(a) + p.y * cos(a));
}

// 1D random numbers
float rand(float n) {
    return fract(sin(n) * 43758.5453123);
}

// 2D random numbers
vec2 rand2( in vec2 p) {
    return fract(vec2(sin(p.x * 591.32 + p.y * 154.077), cos(p.x * 391.32 + p.y * 49.077)));
}

// 1D noise
float noise1(float p) {
    float fl = floor(p);
    float fc = fract(p);
    return mix(rand(fl), rand(fl + 1.0), fc);
}

// Voronoi distance noise
float voronoi( in vec2 x) {
    vec2 p = floor(x);
    vec2 f = fract(x);

    vec2 res = vec2(8.0);
    for (int j = -1; j <= 1; j++) {
        for (int i = -1; i <= 1; i++) {
            vec2 b = vec2(float(i), float(j)); // Casting integers to float
            vec2 r = vec2(b) - f + rand2(p + b);

            float d = max(abs(r.x), abs(r.y));

            if (d < res.x) {
                res.y = res.x;
                res.x = d;
            } else if (d < res.y) {
                res.y = d;
            }
        }
    }
    return res.y - res.x;
}

void fragment() {
    float time = TIME * draw_speed;
    float flicker = noise1(time * 2.0) * 0.8 + 0.4;
    vec2 image_resolution = vec2(textureSize(TEXTURE, 0)); // Cast to vec2
    vec2 uv = FRAGCOORD.xy / image_resolution;
    uv.y = 1.0 - uv.y; // Flip the y-coordinate
    uv = (uv - 0.5) * 2.0;
    vec2 suv = uv;
    uv.x *= image_resolution.x / image_resolution.y;

    float v = 0.0;

    // that looks highly interesting:
    //v = 1.0 - length(uv) * 1.3;


    // a bit of camera movement
    uv *= 0.6 + sin(time * 0.1) * 0.4;
    uv = rotate(uv, sin(time * 0.3) * 1.0);
    uv += time * 0.4;


    // add some noise octaves
    float a = 0.6, f = 1.0;

    for (int i = 0; i < 3; i++) // 4 octaves also look nice, its getting a bit slow though
    {
        float v1 = voronoi(uv * f + 5.0);
        float v2 = 0.0;

        // make the moving electrons-effect for higher octaves
        if (i > 0) {
            // of course everything based on voronoi
            v2 = voronoi(uv * f * 0.5 + 50.0 + time);

            float va = 0.0, vb = 0.0;
            va = 1.0 - smoothstep(0.0, 0.1, v1);
            vb = 1.0 - smoothstep(0.0, 0.08, v2);
            v += a * pow(va * (0.5 + vb), 2.0);
        }

        // make sharp edges
        v1 = 1.0 - smoothstep(0.0, 0.3, v1);

        // noise is used as intensity map
        v2 = a * (noise1(v1 * 5.5 + 0.1));

        // octave 0's intensity changes a bit
        if (i == 0)
            v += v2 * flicker;
        else
            v += v2;

        f *= 3.0;
        a *= 0.7;
    }

    // slight vignetting
    v *= exp(-0.6 * length(suv)) * 1.2;

    // use texture channel0 for color? why not.
    // color calculation (adjust as needed)
    vec3 cexp = texture(texture_channel0, uv * 0.001).xyz * 3.0 + texture(texture_channel0, uv * 0.01).xyz;
    cexp *= 1.4;
    // Sample the original sprite's texture
    vec4 sprite_color = texture(TEXTURE, vec2(FRAGCOORD.x / image_resolution.x, 1.0 - FRAGCOORD.y / image_resolution.y));

    // Determine the intensity of the Voronoi pattern (v is calculated earlier in the code)
    float intensity = clamp(v, 0.0, 1.0); // Adjust intensity as needed

    // Blend the Voronoi pattern with the original sprite's texture
    vec3 col = vec3(pow(v, cexp.x), pow(v, cexp.y), pow(v, cexp.z)) * 2.0;
    vec4 voronoi_color = vec4(col, intensity);

    // Use the alpha channel of voronoi_color to blend with the original sprite color
    COLOR = mix(sprite_color, voronoi_color, voronoi_color.a - 0.30);
}