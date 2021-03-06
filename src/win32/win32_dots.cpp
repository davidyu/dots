#include <windows.h>
#include <math.h>

#include "vertex_shader.hpp"
#include "fragment_shader.hpp"
#include "rasterizer.hpp"

static bool       Running = true;
static BITMAPINFO BitmapInfo;
static void*      BitmapMemory;
static int        BitmapWidth;
static int        BitmapHeight;
static int        Tick;

static Rasterizer RasterizerInstance;

class BasicVertexShader: public VertexShader {
    VS_OUT shade( VS_IN in ) override {
        VS_OUT out;
        out.position = ( ProjectionMatrix * ViewMatrix * ModelMatrix ) * in.v.pos; 
        return out;
    }
};

static BasicVertexShader vs;

class BasicFragmentShader: public FragmentShader {
    FS_OUT shade( VS_OUT in ) override {
        FS_OUT out;
        return out;
    }
};

static BasicFragmentShader fs;

static void Draw()
{
    // want to draw a white triangle
    float Vertices[] = { 0, 1, 0
                       , 1, 0, 0
                       ,-1, 0, 0 };

    float Normals[] = { 0, 0, 1
                      , 0, 0, 1
                      , 0, 0, 1 };

    int Indices[] = { 0, 1, 2 };

    RasterizerInstance.BindVertexBuffer( Vertices, countof( Vertices ) );
    RasterizerInstance.BindNormalBuffer( Normals, countof( Normals ) );
    RasterizerInstance.BindIndexBuffer( Indices, countof( Indices ) );

    RasterizerInstance.UseVertexShader( &vs );
    RasterizerInstance.UseFragmentShader( &fs );

    // render
    RasterizerInstance.Render();

    Mat4 mm = identity<4>();
    Mat4 vm = identity<4>();
    Mat4 projection = identity<4>();

    vs.ProjectionMatrix = make_perspective( M_PI / 2, 16.0 / 9.0, 1.0, -1.0 );
    vs.ModelMatrix = mm;
    vs.ViewMatrix = vm;

    BitmapMemory = (void*) RasterizerInstance.GetImage();
}

static void ResizeDIBSection( int Width, int Height )
{
    BitmapWidth = Width;
    BitmapHeight = Height;

    BitmapInfo.bmiHeader.biSize = sizeof( BitmapInfo.bmiHeader );
    BitmapInfo.bmiHeader.biWidth = BitmapWidth;
    BitmapInfo.bmiHeader.biHeight = -BitmapHeight;
    BitmapInfo.bmiHeader.biPlanes = 1;
    BitmapInfo.bmiHeader.biBitCount = 32;
    BitmapInfo.bmiHeader.biCompression = BI_RGB;

    int BytesPerPixel = 4;
    RasterizerInstance.ResizeBuffers( Width, Height );

    Draw();
}

static void UpdateWindow( HDC DeviceContext, RECT * WindowRect, HWND Window, int X, int Y, int Width, int Height )
{
    int WindowWidth = WindowRect->right - WindowRect->left;
    int WindowHeight = WindowRect->bottom - WindowRect->top;

    StretchDIBits( DeviceContext
                 , 0, 0, BitmapWidth, BitmapHeight
                 , 0, 0, WindowWidth, WindowHeight
                 , BitmapMemory
                 , &BitmapInfo
                 , DIB_RGB_COLORS
                 , SRCCOPY );
}

LRESULT CALLBACK MainWindowCallback( HWND   wnd
                                   , UINT   msg
                                   , WPARAM wParam
                                   , LPARAM lParam )
{
    LRESULT Result = 0;

    switch ( msg ) {
        case WM_SIZE:
        {
            RECT ClientRect;
            GetClientRect( wnd, &ClientRect );
            int w = ClientRect.right - ClientRect.left;
            int h = ClientRect.bottom - ClientRect.top;
            ResizeDIBSection( w, h );
            OutputDebugStringA( "WM_SIZE\n" );
        } break;

        case WM_DESTROY:
        {
            Running = false;
            OutputDebugStringA( "WM_DESTROY\n" );
        } break;

        case WM_CLOSE:
        {
            Running = false;
            OutputDebugStringA( "WM_CLOSE\n" );
        } break;

        case WM_ACTIVATEAPP:
        {
            OutputDebugStringA( "WM_ACTIVATEAPP\n" );
        } break;

        case WM_PAINT:
        {
            PAINTSTRUCT Paint;
            HDC DeviceContext = BeginPaint( wnd, &Paint );

            int x = Paint.rcPaint.left;
            int y = Paint.rcPaint.top;
            int w = Paint.rcPaint.right - Paint.rcPaint.left;
            int h = Paint.rcPaint.bottom - Paint.rcPaint.top;

            RECT ClientRect;
            GetClientRect( wnd, &ClientRect );
            UpdateWindow( DeviceContext, &ClientRect, wnd, x, y, w, h );

            EndPaint( wnd, &Paint );
        } break;

        default:
        {
            Result = DefWindowProc( wnd, msg, wParam, lParam );
        } break;
    }
    return Result;
}

int CALLBACK
WinMain( HINSTANCE Instance
       , HINSTANCE PrevInstance
       , LPSTR Cmd
       , int CmdShow )
{
    WNDCLASS WindowClass = {};
    WindowClass.style = CS_OWNDC | CS_HREDRAW | CS_VREDRAW;
    WindowClass.lpfnWndProc = MainWindowCallback;
    WindowClass.hInstance = Instance;
    WindowClass.lpszClassName = "DotsWndClass";

    if ( RegisterClass( &WindowClass ) ) {
        HWND WindowHandle = CreateWindowEx( 0
                                          , WindowClass.lpszClassName
                                          , "Dots"
                                          , WS_OVERLAPPEDWINDOW | WS_VISIBLE
                                          , CW_USEDEFAULT
                                          , CW_USEDEFAULT
                                          , CW_USEDEFAULT
                                          , CW_USEDEFAULT
                                          , 0
                                          , 0
                                          , Instance
                                          , 0 );
        if ( WindowHandle ) {
            MSG Message;
            Tick = 0;
            while ( Running ) {
                while ( PeekMessage( &Message, NULL, 0, 0, PM_REMOVE ) ) {
                    if ( Message.message == WM_QUIT ) {
                        Running = false;
                    }

                    TranslateMessage( &Message );
                    DispatchMessage( &Message );
                }

                Draw();

                HDC DeviceContext = GetDC( WindowHandle );

                RECT ClientRect;
                GetClientRect( WindowHandle, &ClientRect );

                int w = ClientRect.right - ClientRect.left;
                int h = ClientRect.bottom - ClientRect.top;

                UpdateWindow( DeviceContext, &ClientRect, WindowHandle, 0, 0, w, h );

                ReleaseDC( WindowHandle, DeviceContext );

                Tick++;
            }
        } else {

        }
    }

    return 0;
}
