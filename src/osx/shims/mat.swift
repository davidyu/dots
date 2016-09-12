class Matrix {
    var rows: Int
    var cols: Int

    var m: [Float]

    init( rows: Int, cols: Int, m: [Float] ) {
        self.rows = rows
        self.cols = cols
        self.m = m
    }

    subscript( row: Int, col: Int ) -> Float {
        get {
            return m[ cols * row + col ]
        }

        set( newValue ) {
            m[ cols * row + col ] = newValue
        }
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
