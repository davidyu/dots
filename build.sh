BIN=build

mkdir -p $BIN
cd $BIN
xcrun -sdk macosx swiftc ../src/osx_dots.swift
