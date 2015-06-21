#include <stdint.h>

#include "vec.h"
#include "mat.h"

typedef uint8_t uint8;
typedef uint16_t uint16;
typedef uint32_t uint32;

void transpose( const Mat44 in, Mat44& out ) {
    for ( uint8 i = 0; i < 4; i++ ) {
        for ( uint8 j = 0; j < 4; j++ ) {
            out.data[i][j] = in.data[j][i];
        }
    }
}

void matmul( const Mat44 lhs, const Mat44 rhs, Mat44& out ) {
    for ( uint8 i = 0; i < 4; i++ ) {
        for ( uint8 j = 0; j < 4; j++ ) {
            float sum = 0;
            for ( uint8 k = 0; k < 4; k++ ) {
                sum += lhs.data[i][k] * rhs.data[k][j];
            }
            out.data[i][j] = sum;
        }
    }
}

void vecmat( const Vec4 lhs, const Mat44 rhs, Vec4& out ) {
    for ( uint8 i = 0; i < 4; i++ ) {
       float sum = 0;
       for ( uint8 j = 0; j < 4; j++ ) {
           sum += lhs.data[i] * rhs.data[j][i];
       }
       out.data[i] = sum;
    }
}
