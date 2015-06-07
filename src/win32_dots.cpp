#include <windows.h>


#define local_persist static
#define global_variable static
#define internal static

global_variable bool Running = true;
global_variable BITMAPINFO BitmapInfo;
global_variable void * BitmapMemory;
global_variable HBITMAP BitmapHandle;
global_variable HDC BitmapDeviceContext;

internal void ResizeDIBSection( int Width, int Height )
{
    if ( BitmapHandle ) {
        DeleteObject( BitmapHandle );
    }

    if ( !BitmapDeviceContext ) {
        BitmapDeviceContext = CreateCompatibleDC( 0 );
    }

    BitmapInfo.bmiHeader.biSize = sizeof( BitmapInfo.bmiHeader );
    BitmapInfo.bmiHeader.biWidth = Width;
    BitmapInfo.bmiHeader.biHeight = Height;
    BitmapInfo.bmiHeader.biPlanes = 1;
    BitmapInfo.bmiHeader.biBitCount = 32;
    BitmapInfo.bmiHeader.biCompression = BI_RGB;

    BitmapHandle = CreateDIBSection( BitmapDeviceContext
                                   , &BitmapInfo
                                   , DIB_RGB_COLORS
                                   , &BitmapMemory
                                   , 0
                                   , 0 );
}

internal void UpdateWindow( HDC DeviceContext, HWND Window, int X, int Y, int Width, int Height )
{
    StretchDIBits( DeviceContext
                 , X, Y, Width, Height
                 , X, Y, Width, Height
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
            UpdateWindow( DeviceContext, wnd, x, y, w, h );

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
            while ( Running ) {
                BOOL Result = GetMessage( &Message, NULL, 0, 0 );
                if ( Result > 0 ) {
                    TranslateMessage( &Message );
                    DispatchMessage( &Message );
                } else {
                    break;
                }
            }
        } else {

        }
    }

    return 0;
}
