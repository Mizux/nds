cmake_minimum_required(VERSION 2.8)
include(ndsmacros)

project(mizux_test)

add_subdirectory(arm7)
add_subdirectory(arm9)

add_custom_target(${PROJECT_NAME} ALL
  DEPENDS combined_arm7 combined_arm9
  )

# .bin -> .nds
convert_combined_to_nds(
  combined_arm7
  combined_arm9
  ${PROJECT_NAME})
