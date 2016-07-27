import AppKit
import CoreGraphics

public struct Pixel {
    var a:UInt8
    var r:UInt8
    var g:UInt8
    var b:UInt8
}

public func imageFromBitmap( pixels: [Pixel], width: UInt, height:UInt ) -> NSImage {
    let provider = CGDataProviderCreateWithCFData( NSData( bytes: &pixels, length: pixels.count * sizeof( Pixel ) ) )

    let img = CGImageCreate( width,
                             height,
                             8,  // bits per component
                             32, // bits per pixel
                             width * UInt( sizeof( Pixel ) ),
                             CGColorSpaceCreateDeviceRGB(),
                             CGBitmapInfo( CGImageAlphaInfo.PremultipliedFirst.toRaw() ),
                             provider,
                             nil,
                             true,
                             CGColorRenderingIntent.RenderingIntentDefault )

    return NSImage( CGImage: img )
}
