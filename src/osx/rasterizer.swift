class Rasterizer {
    var w: UInt
    var h: UInt

    var frameBuffer: [Pixel]

    init( width: UInt = 0, height: UInt = 0 ) {
        w = width
        h = height
        frameBuffer = [Pixel](count: Int( w * h ), repeatedValue: Pixel( a: 255, r: 0, g: 0, b: 0 ) )
    }

    func resizeBuffers( newWidth: UInt, newHeight: UInt ) {
        if ( w != newWidth || h != newHeight ) {
            w = newWidth
            h = newHeight
            frameBuffer = [Pixel](count: Int( w * h ), repeatedValue: Pixel( a: 255, r: 0, g: 255, b: 0 ) )
        }
    }

    func GetImage() -> [Pixel] {
        return frameBuffer
    }
}
