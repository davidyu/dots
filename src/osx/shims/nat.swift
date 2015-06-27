// bootstrap on type system for peano arithmetic
protocol Nat {
    static func literal() -> Int
}

class Zero:Nat {
    static func literal() -> Int {
        return 0
    }
}

// successor operator
class S<T:Nat>:Nat {
    static func literal() -> Int {
        return 1 + T.literal()
    }
}

typealias One   = S<Zero>
typealias Two   = S<One>
typealias Three = S<Two>
typealias Four  = S<Three>
typealias Five  = S<Four>
typealias Six   = S<Five>
typealias Seven = S<Six>
typealias Eight = S<Seven>
typealias Nine  = S<Eight>
typealias Ten   = S<Nine>
