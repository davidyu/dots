#include <windows.h>
#include <math.h>

static bool       Running = true;
static BITMAPINFO BitmapInfo;
static void*      BitmapMemory;
static int        BitmapWidth;
static int        BitmapHeight;
static int        Tick;

const double PI = atan(1.0) * 4;
const double ScaleX = 1.5;

static void Draw( int Width, int Height )
{
    // want to draw a white triangle
    int BytesPerPixel = 4;
    int Pitch = Width * BytesPerPixel;
    u8 * Row = (u8 *) BitmapMemory;
    for ( int Y = 0; Y < Height; Y++ ) {
        u32 * Pixel = (u32 *) Row;
        for ( int X = 0; X < Width; X++ ) {
            u32 R = (int ) ( 127.5 * ( sin( (double ) 2 * PI * ( Tick + X ) / Width          ) + 1 )  ) ;
            u32 G = (int ) ( 127.5 * ( sin( (double ) 2 * PI * ( Tick + X ) / Width + PI / 2 ) + 1 )  ) ;
            u32 B = (int ) ( 127.5 * ( sin( (double ) 2 * PI * ( Tick + X ) / Width + PI     ) + 1 )  ) ;

            // Little-Endian (BBGGRRxx)
            *Pixel = ( ( R << 16) & 0x00ff0000 )
                   | ( ( G << 8 ) & 0x0000ff00 )
                   | ( ( B ) & 0x0000ff );

            Pixel++;
        }
        Row += Pitch;
    }
}

static void ResizeDIBSection( int Width, int Height )
{
    if ( BitmapMemory ) {
        VirtualFree( BitmapMemory, 0, MEM_RELEASE );
    }

    BitmapWidth = Width;
    BitmapHeight = Height;

    BitmapInfo.bmiHeader.biSize = sizeof( BitmapInfo.bmiHeader );
    BitmapInfo.bmiHeader.biWidth = BitmapWidth;
    BitmapInfo.bmiHeader.biHeight = -BitmapHeight;
    BitmapInfo.bmiHeader.biPlanes = 1;
    BitmapInfo.bmiHeader.biBitCount = 32;
    BitmapInfo.bmiHeader.biCompression = BI_RGB;

    int BytesPerPixel = 4;
    BitmapMemory = VirtualAlloc( 0, BytesPerPixel * Width * Height, MEM_COMMIT, PAGE_READWRITE );

    Draw( Width, Height );
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

                Draw( BitmapWidth, BitmapHeight );

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
