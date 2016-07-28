import AppKit

class WindowDelegate: NSObject, NSWindowDelegate {
    func windowWillClose( notification: NSNotification ) {
        NSApplication.sharedApplication().terminate(0)
    }

    func windowDidResize( notification: NSNotification ) {
        let window = notification.object as! NSWindow
        window.backgroundColor = NSColor( red: CGFloat( 1.0 )
                                        , green: CGFloat( 0.0 )
                                        , blue: CGFloat( 0.0 )
                                        , alpha: CGFloat( 1.0 )
                                        )
    }
}

class ApplicationDelegate: NSObject, NSApplicationDelegate {
    let window: NSWindow

    init( window: NSWindow ) {
        self.window = window
    }

    func applicationDidFinishLaunching( notification: NSNotification ) {
    }
}

func createWindow(args: [String]) -> Int {
    let windowRect = NSMakeRect( 0, 0, 800, 600 )
    let app: NSApplication = NSApplication.sharedApplication()
    app.setActivationPolicy( NSApplicationActivationPolicy.Regular ) // this tells OS X that this is a standard application that appears in the dock

    let window: NSWindow = NSWindow( contentRect : windowRect
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

    let pixels  = [Pixel]( count: Int( 1000 ), repeatedValue: Pixel( a: 255, r: 255, g: 0, b: 0 ) )
    let imgView = NSImageView( frame: NSMakeRect( 0, windowRect.size.height - 4, 250, 4 ) )
    imgView.image = imageFromBitmap( pixels, width: 250, height: 4 )
    window.contentView?.addSubview( imgView )

    app.run()

    return 0
}
