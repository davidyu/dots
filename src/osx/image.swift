import AppKit
import CoreGraphics

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
