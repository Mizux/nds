cmake_minimum_required(VERSION 2.8)
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/devkitarm.cmake)

project(example)

set(CMAKE_VERBOSE_MAKEFILE OFF)

add_subdirectory(mizux_test)
add_subdirectory(hello_world)
add_subdirectory(graphics)
