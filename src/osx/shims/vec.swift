import Darwin

let origin: Vec4 = Vec4( x: 0, y: 0, z: 0, w: 1 )

class Vector {
    var data: [Float]
    var count: Int

    required init( v: [Float] ) {
        self.data = v
        self.count = self.data.count
    }

    subscript( index: Int ) -> Float {
        get             { return data[index]     }
        set( newValue ) { data[index] = newValue }
    }

    var lensq: Float {
        var sum: Float = 0.0
        for n in 0...self.count {
            sum += data[n] * data[n]
        }
        return sum
    }

    var length: Float {
        return sqrt( self.lensq )
    }
}

class Vec2: Vector {
    required init( v: [Float] ) {
        super.init( v: v )
    }

    init( x: Float, y: Float ) {
        super.init( v: [ x, y] )
    }

    var x: Float {
        get      { return data[0] }
        set( x ) { data[0] = x    }
    }

    var y: Float {
        get      { return data[1] }
        set( y ) { data[1] = y    }
    }

    override var lensq: Float {
        return data[0] * data[0] + data[1] * data[1]
    }
}

class Vec3: Vector {
    required init( v: [Float] ) {
        super.init( v: v )
    }

    init( x: Float, y: Float, z: Float ) {
        super.init( v: [ x, y, z ] )
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

    override var lensq: Float {
        return data[0] * data[0] + data[1] * data[1] + data[2] * data[2]
    }
}

class Vec4: Vector {
    required init( v: [Float] ) {
        super.init( v: v )
    }

    init( x: Float, y: Float, z: Float, w: Float ) {
        super.init( v: [ x, y, z, w ] )
    }

    init( r: Float, g: Float, b: Float, a: Float ) {
        super.init( v: [ r, g, b, a ] )
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
        get      { return data[3] }
        set( w ) { data[3] = w    }
    }

    var r: Float {
        get      { return data[0] }
        set( r ) { data[0] = r    }
    }

    var g: Float {
        get      { return data[1] }
        set( g ) { data[1] = g    }
    }

    var b: Float {
        get      { return data[2] }
        set( b ) { data[2] = b    }
    }

    var a: Float {
        get      { return data[3] }
        set( a ) { data[3] = a    }
    }

    override var lensq: Float {
        return data[0] * data[0] + data[1] * data[1] + data[2] * data[2] + data[3] * data[3]
    }
}

func dot<T: Vector>( a: T, b: T ) -> Float {
    var sum: Float = 0.0
    for n in 0...a.count - 1 {
        sum += a[n] * b[n]
    }
    return sum
}

infix operator + { associativity left precedence 140 }
func +<T: Vector>( left: T, right: T ) -> T {
    var values = [Float]( count: left.count, repeatedValue: 0.0 )
    for n in 0...left.count - 1 {
        values[n] = left[n] + right[n]
    }
    return T( v: values )
}
