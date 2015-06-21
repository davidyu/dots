#ifndef DOTS_VERTEX_SHADER_H
#define DOTS_VERTEX_SHADER_H

#include "vert.h"

struct VS_OUT {
    Point3 position;
};

struct VS_IN {
    Vertex v;
};

class VertexShader {
public:
    Mat44 projectionMatrix;
    Mat44 viewMatrix;
    Mat44 modelMatrix;

    virtual VS_OUT shade( VS_IN in ) = 0;
};

#endif
