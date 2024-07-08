#version 460 core

precision highp float;
#include <flutter/runtime_effect.glsl>

const int KERNEL_SIZE = 20;
const int NUM_LEVELS = 10;
const int SKIP = 3;

uniform vec2 uSize;
uniform sampler2D tInput;

out vec4 fragColor;

vec4 tx(vec2 uv, vec2 l) {
    return texture(tInput, uv + l / uSize.xy);
}

void main()
{
    vec2 fragCoord = FlutterFragCoord().xy;
    vec2 uv = fragCoord / uSize.xy;

    // Initialize counts and colors for each level
    int count0 = 0; vec4 colorSum0 = vec4(0.0);
    int count1 = 0; vec4 colorSum1 = vec4(0.0);
    int count2 = 0; vec4 colorSum2 = vec4(0.0);
    int count3 = 0; vec4 colorSum3 = vec4(0.0);
    int count4 = 0; vec4 colorSum4 = vec4(0.0);
    int count5 = 0; vec4 colorSum5 = vec4(0.0);
    int count6 = 0; vec4 colorSum6 = vec4(0.0);
    int count7 = 0; vec4 colorSum7 = vec4(0.0);
    int count8 = 0; vec4 colorSum8 = vec4(0.0);
    int count9 = 0; vec4 colorSum9 = vec4(0.0);

    int KS = int(KERNEL_SIZE / 2);
    for (int i = 0; i < KERNEL_SIZE; i += SKIP) {
        for (int j = 0; j < KERNEL_SIZE; j += SKIP) {
            vec4 t = tx(uv, vec2(i - KS, j - KS));
            int level = int(dot(vec4(1.0), t) / 10.0 * float(NUM_LEVELS));
            
            if (level == 0) { count0 += 1; colorSum0 += t; }
            else if (level == 1) { count1 += 1; colorSum1 += t; }
            else if (level == 2) { count2 += 1; colorSum2 += t; }
            else if (level == 3) { count3 += 1; colorSum3 += t; }
            else if (level == 4) { count4 += 1; colorSum4 += t; }
            else if (level == 5) { count5 += 1; colorSum5 += t; }
            else if (level == 6) { count6 += 1; colorSum6 += t; }
            else if (level == 7) { count7 += 1; colorSum7 += t; }
            else if (level == 8) { count8 += 1; colorSum8 += t; }
            else if (level == 9) { count9 += 1; colorSum9 += t; }
        }
    }

    // Find the maximum and return the average of that
    int mx_index = 0;
    int mx_val = count0;

    if (count1 > mx_val) { mx_index = 1; mx_val = count1; }
    if (count2 > mx_val) { mx_index = 2; mx_val = count2; }
    if (count3 > mx_val) { mx_index = 3; mx_val = count3; }
    if (count4 > mx_val) { mx_index = 4; mx_val = count4; }
    if (count5 > mx_val) { mx_index = 5; mx_val = count5; }
    if (count6 > mx_val) { mx_index = 6; mx_val = count6; }
    if (count7 > mx_val) { mx_index = 7; mx_val = count7; }
    if (count8 > mx_val) { mx_index = 8; mx_val = count8; }
    if (count9 > mx_val) { mx_index = 9; mx_val = count9; }

    if (mx_index == 0) fragColor = colorSum0 / float(mx_val);
    else if (mx_index == 1) fragColor = colorSum1 / float(mx_val);
    else if (mx_index == 2) fragColor = colorSum2 / float(mx_val);
    else if (mx_index == 3) fragColor = colorSum3 / float(mx_val);
    else if (mx_index == 4) fragColor = colorSum4 / float(mx_val);
    else if (mx_index == 5) fragColor = colorSum5 / float(mx_val);
    else if (mx_index == 6) fragColor = colorSum6 / float(mx_val);
    else if (mx_index == 7) fragColor = colorSum7 / float(mx_val);
    else if (mx_index == 8) fragColor = colorSum8 / float(mx_val);
    else if (mx_index == 9) fragColor = colorSum9 / float(mx_val);
}
