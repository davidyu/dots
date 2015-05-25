@echo off
@if not exist build mkdir build
pushd build
cl -Zi ..\src\win32_dots.cpp user32.lib Gdi32.lib
popd
