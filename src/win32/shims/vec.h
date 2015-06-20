template <int n> struct Vec {
    float data[n];
};

template<> struct Vec<4> {
    union {
        float data[4];
        struct { float x, y, z, w; };
        struct { float r, g, b, a; };
    };
};

typedef Vec<4> Vec4;
