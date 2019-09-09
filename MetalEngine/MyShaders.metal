//
//  MyShaders.metal
//  MetalEngine
//
//  Created by Zachary Duncan on 8/25/19.
//  Copyright © 2019 Zachary Duncan. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float3 position;
    float4 color;
};

struct RasterizerData {
    float4 position [[position]];
    float4 color;
};

// Questions:
//   - Where are the arguments for this being set?
//    A: The device?.makeBuffer(...) - It's not 1:1 args to params, but that's where the data comes from
//   - What do the attribute tags mean?
//   - How does the rasterizer know how to interpret my RasterizerData struct?
//   - why does Xcode consider the rd.color property to be of type NSColor when I set it to be float4?

/// Takes the data from the model and prepares it for the rasterizer
vertex RasterizerData basic_vertex_shader(device VertexIn *vertices [[buffer(0)]], uint vertexID [[vertex_id]]) {
    RasterizerData rd;
    
    rd.position = float4(vertices[vertexID].position, 1);
    rd.color = vertices[vertexID].color;
    
    return rd;
}


// Questions:
//   - Since the rasterizer knows to call this fragment shader function, does it do that by looking for
//     a fragment shader function with a parameter type that matches the return type of the vertex shader?

/// Takes the data from the rasterizer and modifies and populates the pixels
fragment half4 basic_fragment_shader(RasterizerData rd [[stage_in]]) {
    float4 color = rd.color;
    
    return half4(color.r, color.g, color.b, color.a);
}
