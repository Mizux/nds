cmake_minimum_required(VERSION 2.8)
project(animate_simple)
include(ndsmacros)

###################
##  Build Tiles  ##
###################

include_directories(SYSTEM ${CMAKE_CURRENT_BINARY_DIR})
add_custom_command(OUTPUT
  ${CMAKE_CURRENT_BINARY_DIR}/man.h
  ${CMAKE_CURRENT_BINARY_DIR}/man.obj
  COMMAND ${GRIT}
  sprites/man.png
  -ffsprites/sprite.grit
  -o${CMAKE_CURRENT_BINARY_DIR}/man
  COMMAND
  ${CMAKE_C_COMPILER}
  -x assembler-with-cpp
  -c ${CMAKE_CURRENT_BINARY_DIR}/man.s
  -o ${CMAKE_CURRENT_BINARY_DIR}/man.obj
  -mthumb -mthumb-interwork
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

include_directories(SYSTEM ${CMAKE_CURRENT_BINARY_DIR})
add_custom_command(OUTPUT
  ${CMAKE_CURRENT_BINARY_DIR}/woman.h
  ${CMAKE_CURRENT_BINARY_DIR}/woman.obj
  COMMAND ${GRIT}
  sprites/woman.png
  -ffsprites/sprite.grit
  -o${CMAKE_CURRENT_BINARY_DIR}/woman
  COMMAND
  ${CMAKE_C_COMPILER}
  -x assembler-with-cpp
  -c ${CMAKE_CURRENT_BINARY_DIR}/woman.s
  -o ${CMAKE_CURRENT_BINARY_DIR}/woman.obj
  -mthumb -mthumb-interwork
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

###############
##  PROGRAM  ##
###############

# Dependencies
find_package(NDS COMPONENTS ARM9 REQUIRED)

include_directories(SYSTEM ${NDS_INCLUDE_DIRS})
add_definitions(${NDS_DEFINITIONS})

# Executable
add_executable(${PROJECT_NAME}
  src/main.cpp
  man.obj woman.obj)
set_target_properties(${PROJECT_NAME} PROPERTIES
  COMPILER_FLAGS ${NDS_COMPILER_FLAGS}
  LINK_FLAGS ${NDS_LINK_FLAGS})
target_link_libraries(${PROJECT_NAME} ${NDS_LIBRARIES})

##################
##  CONVERTION  ##
##################

# ELF -> .bin
convert_to_bin(${PROJECT_NAME})
# .bin -> .nds
convert_to_nds(${PROJECT_NAME})
