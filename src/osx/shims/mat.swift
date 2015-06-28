protocol Matrix {
    var m : [Float] { get set }
    subscript( row: Int, col: Int ) -> Float { get set }
}

struct Mat<R:Nat, C:Nat>: Matrix {
    private var rows = R.literal()
    private var cols = C.literal()
    var m = [Float]( count: self.rows * self.cols, repeatedValue: 0.0 )
    subscript( row: Int, col: Int ) -> Float {
        get {
            return m[ cols * row + col ]
        }

        set( newValue ) {
            m[ cols * row + col ] = newValue
        }
    }
}
