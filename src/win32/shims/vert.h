#ifndef DOTS_VERTEX_H
#define DOTS_VERTEX_H

#include "color.hpp"
#include "vec.hpp"

struct Vertex {
    Vec4 pos;
    Vec4 normal;
    Color color;
};

#endif
