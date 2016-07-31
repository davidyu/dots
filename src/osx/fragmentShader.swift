struct FS_OUT {
    var color: Pixel
}

class FragmentShader {
    func shade( in: VS_OUT ) -> FS_OUT {
        return FS_OUT( color: Pixel( a: 255, r: 0, g: 0, b: 0 ) )
    }
}
