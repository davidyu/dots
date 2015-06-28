import Darwin

// hide me
protocol Vector {
    var data: [Float] { get }
    subscript( index: Int ) -> Float { get set }
    var lensq: Float { get }
    var length: Float { get }
}

// expose me
struct Vec<T:Nat>: Vector {
    var data = [Float]( count: T.literal(), repeatedValue: 0.0 )
    subscript( index: Int ) -> Float {
        get             { return data[index]     }
        set( newValue ) { data[index] = newValue }
    }
    var lensq: Float {
        var lensq: Float = 0.0
        for n in 0...T.literal() - 1 {
            lensq += data[n] * data[n]
        }
        return lensq
    }
    init( v: [Float] ) {
        self.data = Array( data[0...T.literal()] )
    }
    var length: Float {
        return sqrt( self.lensq )
    }
}

// hide me
protocol SpecializedVector {
    var count: Int { get }
    init( v: [Float] )
    subscript( index: Int ) -> Float { get set }
}

// expose me
struct Vec2: Vector, SpecializedVector {
    let count = 2
    var data = [Float]( count: 2, repeatedValue: 0.0 )
    subscript( index: Int ) -> Float {
        get             { return data[index]     }
        set( newValue ) { data[index] = newValue }
    }
    var x: Float {
        get      { return data[0] }
        set( x ) { data[0] = x    }
    }
    var y: Float {
        get      { return data[1] }
        set( y ) { data[1] = y    }
    }
    init( v: [Float] ) {
        self.data = [data[0], data[1]]
    }
    init( x: Float, y: Float ) {
        self.data = [x,y]
    }
    var lensq: Float {
        return data[0] * data[0] + data[1] * data[1]
    }
    var length: Float {
        return sqrt( self.lensq )
    }
}

struct Vec3: Vector, SpecializedVector {
    let count = 3
    var data = [Float]( count: 3, repeatedValue: 0.0 )
    subscript( index: Int ) -> Float {
        get             { return data[index]     }
        set( newValue ) { data[index] = newValue }
    }
    var x: Float {
        get      { return data[0] }
        set( x ) { data[0] = x    }
    }
    var y: Float {
        get      { return data[1] }
        set( y ) { data[1] = y    }
    }
    var z: Float {
        get      { return data[2] }
        set( z ) { data[2] = z    }
    }
    init( v: [Float] ) {
        self.data = Array(data[0...2])
    }
    init( x: Float, y: Float, z: Float ) {
        self.data = [x,y,z]
    }
    var lensq: Float {
        return data[0] * data[0] + data[1] * data[1] + data[2] * data[2]
    }
    var length: Float {
        return sqrt( self.lensq )
    }
}

struct Vec4: Vector {
    let count = 4
    var data = [Float]( count: 4, repeatedValue: 0.0 )
    subscript( index: Int ) -> Float {
        get             { return data[index]     }
        set( newValue ) { data[index] = newValue }
    }
    var x: Float {
        get      { return data[0] }
        set( x ) { data[0] = x    }
    }
    var y: Float {
        get      { return data[1] }
        set( y ) { data[1] = y    }
    }
    var z: Float {
        get      { return data[2] }
        set( z ) { data[2] = z    }
    }
    var w: Float {
        get      { return data[2] }
        set( w ) { data[2] = w    }
    }
    init( v: [Float] ) {
        self.data = Array(data[0...3])
    }
    init( x: Float, y: Float, z: Float, w: Float ) {
        self.data = [x,y,z,w]
    }
    var lensq: Float {
        return data[0] * data[0] + data[1] * data[1] + data[2] * data[2] + data[3] * data[3]
    }
    var length: Float {
        return sqrt( self.lensq )
    }
}

func dot<T:Nat>( a: Vec<T>, b: Vec<T> ) -> Float {
    var sum: Float = 0.0
    for n in 0...T.literal() - 1 {
        sum += a[n] * b[n]
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
