#ifndef DOTS_VECTOR_H
struct Vec4;
#endif

#ifndef DOTS_MATRIX_H
#define DOTS_MATRIX_H

template <int rows, int cols> struct Mat {
    float data[rows][cols];
};

typedef Mat<4,4> Mat44;

void transpose( const Mat44 in, Mat44& out );
void matmul( const Mat44 lhs, const Mat44 rhs, Mat44& out );
void vecmat( const Vec4 lhs, const Mat44 rhs, Vec4& out );


inline Mat44 operator *( const Mat44& lhs, const Mat44& rhs ) {
    Mat44 out;
    matmul( lhs, rhs, out );
    return out;
}

inline Vec4 operator *( const Vec4& lhs, const Mat44& rhs ) {
    Vec4 out;
    vecmat( lhs, rhs, out );
    return out;
}

#endif
