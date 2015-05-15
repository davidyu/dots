#include <windows.h>

LRESULT CALLBACK MainWindowCallback( HWND   wnd
                                   , UINT   msg
                                   , WPARAM wParam
                                   , LPARAM lParam )
{
    LRESULT Result = 0;

    switch ( msg ) {
        case WM_SIZE:
        {
            OutputDebugStringA( "WM_SIZE\n" );
        } break;

        case WM_DESTROY:
        {
            OutputDebugStringA( "WM_DESTROY\n" );
        } break;

        case WM_CLOSE:
        {
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

            static DWORD op = WHITENESS;

            PatBlt( DeviceContext, x, y, w, h, op );

            if ( op == WHITENESS ) {
                op = BLACKNESS;
            } else {
                op = WHITENESS;
            }

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
            for ( ;; ) {
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
