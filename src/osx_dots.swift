import AppKit

func main(args: [String]) -> Int {
    var app: NSApplication = NSApplication.sharedApplication()

    var window: NSWindow = NSWindow( contentRect : NSMakeRect( 0, 0, 100, 100 )
                                   , styleMask   : NSBorderlessWindowMask
                                   , backing     : NSBackingStoreType.Buffered
                                   , defer       : true )

    window.makeKeyAndOrderFront( window )

    return 0
}

main(Process.arguments)
