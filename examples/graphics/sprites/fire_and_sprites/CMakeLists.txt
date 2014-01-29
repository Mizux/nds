cmake_minimum_required(VERSION 2.8)
project(fire_and_sprites)
include(ndsmacros)

###################
##  Build Datas  ##
###################

include_directories(SYSTEM ${CMAKE_CURRENT_BINARY_DIR})
add_custom_command(OUTPUT
  ${CMAKE_CURRENT_BINARY_DIR}/ball.obj
  COMMAND ${BIN2S} data/ball.pcx |
	${CMAKE_AS_COMPILER} -o ${CMAKE_CURRENT_BINARY_DIR}/ball.obj
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
set(DATA_HDR ${CMAKE_CURRENT_BINARY_DIR}/ball_pcx.h)
file(WRITE ${DATA_HDR} "extern const u8 ball_pcx_end[];")
file(APPEND ${DATA_HDR} "extern const u8 ball_pcx[];")
file(APPEND ${DATA_HDR} "extern const u32 ball_pcx_size;")

# Dependencies
find_package(NDS COMPONENTS ARM9 REQUIRED)

include_directories(SYSTEM ${NDS_INCLUDE_DIRS})
add_definitions(${NDS_DEFINITIONS})

# Executable
add_executable(${PROJECT_NAME}
  src/main.cpp
  ball_pcx.h
  ball.obj)
set_target_properties(${PROJECT_NAME} PROPERTIES
  COMPILER_FLAGS ${NDS_COMPILER_FLAGS}
  LINK_FLAGS ${NDS_LINK_FLAGS})
target_link_libraries(${PROJECT_NAME} ${NDS_LIBRARIES})

# ELF -> .bin
convert_to_bin(${PROJECT_NAME})
# .bin -> .nds
convert_to_nds(${PROJECT_NAME})
