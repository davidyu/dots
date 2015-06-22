#include "camera.h"

// the view matrix is inv( CameraBasis ) * (-CameraTranslation)
// to understand why, recall that a view matrix transforms vectors from world
// space into eye space. To do this, we multiply the world space position by
// the inverse eye basis. Then we move everything by the inverse of the eye
// translation (or the result of negating the camera position)
Mat44 Camera::GetViewMatrix() {
    auto xaxis = right;
    auto yaxis = up;
    auto zaxis = aim;

    // TODO make sure this matrix is orthonormal/
    Mat44 inverseEyeBasis = fromRows( xaxis, yaxis, zaxis, Vec4( 0, 0, 0, 1 ) );
    Mat44 inverseEyeTranslate = fromCols( Vec4( 1, 0, 0, 0 ), Vec4( 0, 1, 0, 0 ), Vec4( 0, 0, 1, 0 ), Vec4( -pos.x, -pos.y, -pos.z, 1 ) );

    Mat44 viewMatrix = inverseEyeBasis * inverseEyeTranslate;
    return viewMatrix;
}
