protocol Matrix {
    var m : [Float] { get set }
    subscript( row: Int, col: Int ) -> Float { get set }
}

struct Mat<R:Nat, C:Nat>: Matrix {
    private var rows = R.literal()
    private var cols = C.literal()
    var m = [Float]( count: R.literal() * C.literal(), repeatedValue: 0.0 )
    subscript( row: Int, col: Int ) -> Float {
        get {
            return m[ cols * row + col ]
        }

        set( newValue ) {
            m[ cols * row + col ] = newValue
        }
    }
    init( m: [Float] ) {
        self.m = m
    }
}

func fromRows<R:Nat, C:Nat>( rows: [Vec<C>] ) -> Mat<R, C> {
    var m: [Float] = []
    for r in rows {
        m += r.data
    }
    return Mat<R,C>( m: m )
}

func fromCols<R:Nat, C:Nat>( cols: [Vec<R>] ) -> Mat<R, C> {
    var m: [Float] = []
    for r in 0...R.literal() - 1 {
        for c in cols {
            m.append( c.data[r] )
        }
    }
    return Mat<R,C>( m: m )
}

func transpose<R:Nat, C:Nat>( mat: Mat<R, C> ) -> Mat<C, R> {
    var m: [Float] = []

    for r in 0...R.literal() - 1 {
        for c in 0...C.literal() - 1 {
            m.append( mat[ c, r ] )
        }
    }

    return Mat<C,R>( m: m )
}
