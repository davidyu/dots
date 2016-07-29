import AppKit
import CoreGraphics

// TODO: move me into the relevant class
var screenView = NSImageView( frame: NSMakeRect( 0, 0, 800, 600 ) )

class WindowDelegate: NSObject, NSWindowDelegate {
    func windowWillClose( notification: NSNotification ) {
        NSApplication.sharedApplication().terminate(0)
    }

    func windowDidResize( notification: NSNotification ) {
        let window = notification.object as! NSWindow
        resizeWindow( window )
    }
}

class ApplicationDelegate: NSObject, NSApplicationDelegate {
    let window: NSWindow

    init( window: NSWindow ) {
        self.window = window
    }

    func applicationDidFinishLaunching( notification: NSNotification ) {
        let frame = window.contentView!.frame

        let w = frame.size.width
        let h = frame.size.height
    
        screenView.frame.size.width = w
        screenView.frame.size.height = h
        screenView.frame.origin.x = 0
        screenView.frame.origin.y = 0

        let pixels  = [Pixel]( count: Int( w * h ), repeatedValue: Pixel( a: 255, r: 255, g: 0, b: 0 ) )
        screenView.image = imageFromBitmap( pixels, width: Int( w ), height: Int( h ) )

        self.window.contentView?.addSubview( screenView )
    }
}

public func imageFromBitmap( pixels: [Pixel], width: Int, height:Int ) -> NSImage {
    var data = pixels
    let provider = CGDataProviderCreateWithCFData( NSData( bytes: &data, length: pixels.count * sizeof( Pixel ) ) )

    let img = CGImageCreate( width,
                             height,
                             8,  // bits per component
                             32, // bits per pixel
                             width * Int( sizeof( Pixel ) ),
                             CGColorSpaceCreateDeviceRGB(),
                             CGBitmapInfo( rawValue: CGImageAlphaInfo.PremultipliedFirst.rawValue ),
                             provider,
                             nil,
                             true,
                             CGColorRenderingIntent.RenderingIntentDefault )

    return NSImage( CGImage: img!, size: CGSize( width: width, height: height ) )
}

func resizeWindow( window: NSWindow ) {
    let frame = window.contentView!.frame

    let w = frame.size.width
    let h = frame.size.height

    // only repaint if necessary
    if ( w != screenView.frame.size.width || h == screenView.frame.size.height ) {
        screenView.frame.size.width = w
        screenView.frame.size.height = h

        let pixels  = [Pixel]( count: Int( w * h ), repeatedValue: Pixel( a: 255, r: 255, g: 0, b: 0 ) )
        screenView.image = imageFromBitmap( pixels, width: Int( w ), height: Int( h ) )
    }
}

func createWindow( args: [String] ) -> Int {
    var w = CGFloat( 800 )
    var h = CGFloat( 600 )

    if ( args.count >= 3 ) {
        w = CGFloat( Float( args[1] )! )
        h = CGFloat( Float( args[2] )! )
    }

    let windowRect = NSMakeRect( 0, 0, w, h )

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

    app.run()

    return 0
}
