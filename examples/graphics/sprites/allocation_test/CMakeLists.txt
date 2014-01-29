cmake_minimum_required(VERSION 2.8)
project(allocation_test)
include(ndsmacros)

# Dependencies
find_package(NDS COMPONENTS ARM9 REQUIRED)

include_directories(SYSTEM ${NDS_INCLUDE_DIRS})
add_definitions(${NDS_DEFINITIONS})

# Executable
add_executable(${PROJECT_NAME} src/main.cpp)
set_target_properties(${PROJECT_NAME} PROPERTIES
  COMPILER_FLAGS ${NDS_COMPILER_FLAGS}
  LINK_FLAGS ${NDS_LINK_FLAGS})
target_link_libraries(${PROJECT_NAME} ${NDS_LIBRARIES})

# ELF -> .bin
convert_to_bin(${PROJECT_NAME})
# .bin -> .nds
convert_to_nds(${PROJECT_NAME})
