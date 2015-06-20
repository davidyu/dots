#ifndef DOTS_MATRIX_H
#define DOTS_MATRIX_H

#include "vec.h"

template <int rows, int cols> struct Mat {
    float data[rows][cols];
};

typedef Mat<4,4> Mat44;

#endif
