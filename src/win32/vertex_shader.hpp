#pragma once

#include "vert.h"
#include "mat.hpp"

struct VS_OUT {
    Vec4 position;
};

struct VS_IN {
    Vertex v;
};

class VertexShader {
public:
    Mat4 ProjectionMatrix;
    Mat4 ViewMatrix;
    Mat4 ModelMatrix;

    virtual VS_OUT shade( VS_IN in ) = 0;
};
