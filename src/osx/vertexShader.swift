struct VS_OUT {
    var pos: Vec4
}

struct VS_IN {
    var pos   : Vec4
    var normal: Vec4
    var color : Color
}

class VertexShader {
    func shade( in: VS_IN ) -> VS_OUT {
        let out: VS_OUT = VS_OUT( pos: origin )
        return out
    }
}
