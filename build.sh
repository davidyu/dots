BIN=build

mkdir -p $BIN
cd $BIN
xcrun -sdk macosx swiftc ../src/osx/osx_dots.swift ../src/osx/shims/pixel.swift ../src/osx/rasterizer.swift ../src/osx/vertexShader.swift ../src/osx/fragmentShader.swift ../src/osx/shims/vec.swift ../src/osx/shims/mat.swift ../src/osx/shims/nat.swift ../src/osx/main.swift
