// bootstrap on type system for peano arithmetic
protocol Nat {
}

class Zero:Nat {
}

// successor operator
class S<T:Nat>:Nat {}

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
