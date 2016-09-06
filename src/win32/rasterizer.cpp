#include "rasterizer.hpp"

#include "vec.hpp"
#include "color.hpp"
#include "vertex_shader.hpp"
#include "fragment_shader.hpp"

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

struct VS_DAT {
    VS_IN  In;
    VS_OUT Out;
};

void Rasterizer::Render() {
    // assemble input
    VS_DAT * VSData = new VS_DAT[ VertexBufferSize ];

    for ( uint i = 0; i < VertexBufferSize; i += 3 ) {
        VSData[i].In.v.pos    = { VertexBuffer[i] , VertexBuffer[i + 1] , VertexBuffer[i + 2] , 1 };
        VSData[i].In.v.normal = { NormalBuffer[i] , NormalBuffer[i + 1] , NormalBuffer[i + 2] , 0 };
        VSData[i].In.v.color  = { 1, 0, 0, 1 };
    }

    for ( uint i = 0; i < VertexBufferSize; i += 3 ) {
        VSData[i].Out = VS->shade( VSData[i].In );
    }
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
