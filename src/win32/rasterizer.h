//
// The software rasterizer
//

class VertexShader;
class FragmentShader;

class Rasterizer {
private:
    VertexShader   * VS;
    FragmentShader * FS;

    u16 Width;
    u16 Height;

    u8  * Framebuffer;
    u8  * Backbuffer;
    u32 * Depthbuffer;

    float * VertexBuffer;
    u32     VertexBufferSize;
    float * NormalBuffer;
    u32     NormalBufferSize;
    int *   IndexBuffer;
    u32     IndexBufferSize;

public:
    void BindVertexBuffer( float * Buffer, int Count );
    void BindNormalBuffer( float * Buffer, int Count );
    void BindIndexBuffer ( int * Buffer, int Count );

    u8 * GetImage();
    bool ResizeBuffers( int NewWidth, int NewHeight );

    Rasterizer();
    ~Rasterizer();
};
