BIN=build

mkdir -p $BIN
cd $BIN
xcrun -sdk macosx swiftc ../src/osx/osx_dots.swift ../src/osx/shims/vec.swift
