#ifndef DOTS_VERTEX_SHADER_H
#define DOTS_VERTEX_SHADER_H

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
    Mat4 projectionMatrix;
    Mat4 viewMatrix;
    Mat4 modelMatrix;

    virtual VS_OUT shade( VS_IN in ) = 0;
};

#endif
