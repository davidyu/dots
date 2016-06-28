#include "rasterizer.h"

#include "vec.hpp"
#include "vertex_shader.h"
#include "fragment_shader.h"

Rasterizer::Rasterizer()
    : VS( null )
    , FS( null )
    , Framebuffer( null )
    , Backbuffer( null )
    , Depthbuffer( null ) {
}

Rasterizer::~Rasterizer() {}

u8 * Rasterizer::GetImage() {
    return Framebuffer;
}

void Rasterizer::BindVertexBuffer( float * Buffer, int Count ) {
    VertexBuffer = Buffer;
    VertexBufferSize = Count;
}

void Rasterizer::BindNormalBuffer( float * Buffer, int Count ) {
    NormalBuffer = Buffer;
    NormalBufferSize = Count;
}

void Rasterizer::BindIndexBuffer( int * Buffer, int Count ) {
    IndexBuffer = Buffer;
    IndexBufferSize = Count;
}

void Rasterizer::UseVertexShader( VertexShader * Shader ) {
    VS = Shader;
}

void Rasterizer::UseFragmentShader( FragmentShader * Shader ) {
    FS = Shader;
}

void Rasterizer::Render() {

}

bool Rasterizer::ResizeBuffers( int NewWidth, int NewHeight ) {
    bool Success = false;

    int NewDim = NewWidth * NewHeight;
    int OldDim = Width * Height;

    if ( NewDim > OldDim ) {
        if ( Framebuffer != null ) delete[] Framebuffer;
        if ( Backbuffer  != null ) delete[] Backbuffer;
        if ( Depthbuffer != null ) delete[] Depthbuffer;

        Framebuffer  = new u8 [ NewDim * 4 ]; // RGBA
        Backbuffer   = new u8 [ NewDim * 4 ]; // RGBA
        Depthbuffer  = new u32[ NewDim ];

        Success = Framebuffer != null && Backbuffer != null && Depthbuffer != null;

        if ( Success ) {
            Width = NewWidth;
            Height = NewHeight;
        }
    }

    return Success;
}
