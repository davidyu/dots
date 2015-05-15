import AppKit

func main(args: [String]) -> Int {
    var window: NSWindow = NSWindow( contentRect : NSMakeRect( 0, 0, 100, 100 )
                                   , styleMask   : NSBorderlessWindowMask
                                   , backing     : .Buffered
                                   , defer       : false )
    return 0
}

main(Process.arguments)
