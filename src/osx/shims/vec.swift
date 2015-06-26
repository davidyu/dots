// unsafe base
struct Vec<T:Nat> {
    var v:[Float]
}

struct Vec<Four> {
    var v = [Float]( count: 4, repeatedValue: 0.0 )
}

struct Vec<Three> {
    var v = [Float]( count: 3, repeatedValue: 0.0 )
}

struct Vec<Two> {
    var v = [Float]( count: 2, repeatedValue: 0.0 )
}

typealias Vec4 = Vec<Four>
typealias Vec3 = Vec<Three>
typealias Vec2 = Vec<Two>
