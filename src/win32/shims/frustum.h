#include "mat.hpp"

class ViewFrustum {
    float zNear;
    float zFar;
    float fovyRad;
    float aspectRatio;

    Mat4 GetProjectionMatrix();
};
