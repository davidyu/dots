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
public:
    u8 * GetImage( int Width, int Height );
    bool ResizeBuffers( int NewWidth, int NewHeight );

    Rasterizer();
    ~Rasterizer();
};
