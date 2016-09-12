class Matrix {
    var rows: Int
    var cols: Int

    var data: [Float]

    required init( rows: Int, cols: Int, m: [Float] ) {
        self.rows = rows
        self.cols = cols
        self.data = m
    }

    subscript( row: Int, col: Int ) -> Float {
        get {
            return data[ cols * row + col ]
        }

        set( newValue ) {
            data[ cols * row + col ] = newValue
        }
    }
}

class Mat3: Matrix {
    required init( rows: Int, cols: Int, m: [Float] ) {
        super.init( rows: rows, cols: cols, m: m )
    }

    init( m: [Float] ) {
        super.init( rows: 3, cols: 3, m: m )
    }

    var m00: Float {
        get        { return data[0] }
        set( m00 ) { data[0] = m00  }
    }

    var m01: Float {
        get        { return data[1] }
        set( m01 ) { data[1] = m01  }
    }

    var m02: Float {
        get        { return data[2] }
        set( m02 ) { data[2] = m02  }
    }

    var m10: Float {
        get        { return data[3] }
        set( m10 ) { data[3] = m10  }
    }

    var m11: Float {
        get        { return data[4] }
        set( m11 ) { data[4] = m11  }
    }

    var m12: Float {
        get        { return data[5] }
        set( m12 ) { data[5] = m12  }
    }

    var m20: Float {
        get        { return data[6] }
        set( m20 ) { data[6] = m20  }
    }

    var m21: Float {
        get        { return data[7] }
        set( m21 ) { data[7] = m21  }
    }

    var m22: Float {
        get        { return data[8] }
        set( m22 ) { data[8] = m22  }
    }
}

func fromRows<V:Vector>( rows: [V] ) -> Matrix {
    var m: [Float] = []
    for r in rows {
        m += r.data
    }
    return Matrix( rows: rows.count, cols: rows[0].count, m: m )
}

func fromCols<V:Vector>( cols: [V] ) -> Matrix {
    var m: [Float] = []

    for r in 0...cols[0].count {
        for c in cols {
            m.append( c.data[r] )
        }
    }

    return Matrix( rows: cols[0].count, cols: cols.count, m: m )
}

func transpose( mat: Matrix ) -> Matrix {
    var m: [Float] = []

    for r in 0...mat.rows - 1 {
        for c in 0...mat.cols - 1 {
            m.append( mat[ c, r ] )
        }
    }

    return Matrix( rows: mat.cols, cols: mat.rows, m: m )
}
