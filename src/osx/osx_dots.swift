import AppKit

class WindowDelegate: NSObject, NSWindowDelegate {
    func windowWillClose( notification: NSNotification ) {
        NSApplication.sharedApplication().terminate(0)
    }

    func windowDidResize( notification: NSNotification ) {
        var window = notification.object as! NSWindow
        window.backgroundColor = NSColor( red: CGFloat( 1.0 )
                                        , green: CGFloat( 0.0 )
                                        , blue: CGFloat( 0.0 )
                                        , alpha: CGFloat( 1.0 )
                                        )
    }
}

class ApplicationDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow

    init( window: NSWindow ) {
        self.window = window
    }

    func applicationDidFinishLaunching( notification: NSNotification ) {
    }
}

func main(args: [String]) -> Int {
    var app: NSApplication = NSApplication.sharedApplication()
    app.setActivationPolicy( NSApplicationActivationPolicy.Regular ) // this tells OS X that this is a standard application that appears in the dock

    var window: NSWindow = NSWindow( contentRect : NSMakeRect( 0, 0, 800, 600 )
                                   , styleMask   : NSTitledWindowMask | NSClosableWindowMask | NSResizableWindowMask
                                   , backing     : NSBackingStoreType.Buffered
                                   , defer       : true )

    window.center()
    window.title = "Dots"
    window.makeKeyAndOrderFront( window )

    let windDelegate = WindowDelegate()
    window.delegate = windDelegate

    let appDelegate = ApplicationDelegate( window: window )
    app.delegate = appDelegate
    app.activateIgnoringOtherApps( true )
    app.run()

    return 0
}

main(Process.arguments)
