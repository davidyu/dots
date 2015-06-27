// unsafe base

protocol Vector {
    var v: [Float] { get set }
}

struct Vec<T:Nat>: Vector {
    var v = [Float]( count: T.literal(), repeatedValue: 0.0 )
}

struct Vec2: Vector {
    var v = [Float]( count: 2, repeatedValue: 0.0 )
    var x: Float {
        get      { return v[0] }
        set( x ) { v[0] = x    }
    }
    var y: Float {
        get      { return v[1] }
        set( y ) { v[1] = y    }
    }
}

struct Vec3: Vector {
    var v = [Float]( count: 3, repeatedValue: 0.0 )
    var x: Float {
        get      { return v[0] }
        set( x ) { v[0] = x    }
    }
    var y: Float {
        get      { return v[1] }
        set( y ) { v[1] = y    }
    }
    var z: Float {
        get      { return v[2] }
        set( z ) { v[2] = z    }
    }
}


struct Vec4: Vector {
    var v = [Float]( count: 4, repeatedValue: 0.0 )
    var x: Float {
        get      { return v[0] }
        set( x ) { v[0] = x    }
    }
    var y: Float {
        get      { return v[1] }
        set( y ) { v[1] = y    }
    }
    var z: Float {
        get      { return v[2] }
        set( z ) { v[2] = z    }
    }
    var w: Float {
        get      { return v[2] }
        set( w ) { v[2] = w    }
    }
}

func dot<T:Nat>( a: Vec<T>, b: Vec<T> ) -> Float {
    var sum: Float = 0.0
    for n in 0...T.literal() - 1 {
        sum += a.v[n] * b.v[n]
    }
    return sum
}
