#include "vec.hpp"
#include "mat.hpp"

class Camera {
    Vec4 pos;
    Vec4 aim;
    Vec4 right;
    Vec4 up;

    Mat4 GetViewMatrix();
};
