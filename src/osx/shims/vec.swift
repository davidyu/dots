// unsafe base

protocol Vector {
    subscript( index: Int ) -> Float { get set }
}

struct Vec<T:Nat>: Vector {
    private var v = [Float]( count: T.literal(), repeatedValue: 0.0 )
    subscript( index: Int ) -> Float {
        get {
            return v[index]
        }
        set( newValue ) {
            v[index] = newValue
        }
    }
}

protocol SpecializedVector {
    var count: Int { get }
    init( v: [Float] )
    subscript( index: Int ) -> Float { get set }
}

struct Vec2: Vector, SpecializedVector {
    var count = 2
    private var v = [Float]( count: 2, repeatedValue: 0.0 )
    subscript( index: Int ) -> Float {
        get             { return v[index]     }
        set( newValue ) { v[index] = newValue }
    }
    var x: Float {
        get      { return v[0] }
        set( x ) { v[0] = x    }
    }
    var y: Float {
        get      { return v[1] }
        set( y ) { v[1] = y    }
    }
    init( v: [Float] ) {
        self.v = [v[0], v[1]]
    }
    init( x: Float, y: Float ) {
        self.v = [x,y]
    }
}

struct Vec3: Vector, SpecializedVector {
    var count = 3
    private var v = [Float]( count: 3, repeatedValue: 0.0 )
    subscript( index: Int ) -> Float {
        get             { return v[index]     }
        set( newValue ) { v[index] = newValue }
    }
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
    init( v: [Float] ) {
        self.v = Array(v[0...2])
    }
    init( x: Float, y: Float, z: Float ) {
        self.v = [x,y,z]
    }
}


struct Vec4: Vector {
    var count = 4
    private var v = [Float]( count: 4, repeatedValue: 0.0 )
    subscript( index: Int ) -> Float {
        get             { return v[index]     }
        set( newValue ) { v[index] = newValue }
    }
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
    init( v: [Float] ) {
        self.v = Array(v[0...3])
    }
    init( x: Float, y: Float, z: Float, w: Float ) {
        self.v = [x,y,z,w]
    }
}

func dot<T:Nat>( a: Vec<T>, b: Vec<T> ) -> Float {
    var sum: Float = 0.0
    for n in 0...T.literal() - 1 {
        sum += a.v[n] * b.v[n]
    }
    return sum
}

infix operator + { associativity left precedence 140 }
func +<T:Nat>( left: Vec<T>, right: Vec<T> ) -> Vec<T> {
    var values = [Float]( count: T.literal(), repeatedValue: 0.0 )
    for n in 0...T.literal() - 1 {
        values[n] = left[n] + right[n]
    }
    return Vec<T>( v: values )
}

func +<T: SpecializedVector>( left: T, right: T ) -> T {
    var values = [Float]( count: left.count, repeatedValue: 0.0 )
    for n in 0...left.count - 1 {
        values[n] = left[n] + right[n]
    }
    return T( v: values )
}
