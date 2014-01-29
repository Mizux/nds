cmake_minimum_required(VERSION 2.8)

project(combined_arm7)

# Dependencies
find_package(NDS COMPONENTS ARM7 REQUIRED)
find_package(MM COMPONENTS ARM7 REQUIRED)
find_package(DSWIFI COMPONENTS ARM7 REQUIRED)

include_directories(SYSTEM ${NDS_INCLUDE_DIRS})
include_directories(SYSTEM ${MM_INCLUDE_DIRS})
include_directories(SYSTEM ${DSWIFI_INCLUDE_DIRS})
add_definitions(${NDS_DEFINITIONS})

# Executable
add_executable(${PROJECT_NAME} src/main.cpp)
set_target_properties(${PROJECT_NAME} PROPERTIES
  COMPILER_FLAGS ${NDS_COMPILER_FLAGS}
  LINK_FLAGS ${NDS_LINK_FLAGS})
target_link_libraries(${PROJECT_NAME}
  ${NDS_LIBRARIES}
  ${MM_LIBRARIES}
  ${DSWIFI_LIBRARIES})

# ELF -> .bin
convert_to_bin(${PROJECT_NAME})
