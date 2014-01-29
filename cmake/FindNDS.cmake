cmake_minimum_required(VERSION 2.8)

# LibNDS + configuration for arm7 or arm9
message(STATUS "Looking for libnds...")
set(NDS_INCLUDE_DIRS ${CMAKE_CURRENT_LIST_DIR}/../libnds/include)
message(STATUS "Looking for libnds: ${NDS_INCLUDE_DIRS} - found")

if(${NDS_FIND_COMPONENTS} MATCHES ARM9)
  set(NDS_DEFINITIONS "-DARM9")
  set(NDS_LIBRARIES ${CMAKE_CURRENT_LIST_DIR}/../libnds/lib/libnds9.a)
  set(NDS_COMPILER_FLAGS "-march=armv5te -mtune=arm946e-s -mthumb -mthumb-interwork")
  set(NDS_LINK_FLAGS "-specs=ds_arm9.specs")
endif()
if(${NDS_FIND_COMPONENTS} MATCHES ARM7)
  set(NDS_DEFINITIONS "-DARM7")
  set(NDS_LIBRARIES ${CMAKE_CURRENT_LIST_DIR}/../libnds/lib/libnds7.a)
  set(NDS_COMPILER_FLAGS "-mcpu=arm7tdmi -mtune=arm7tdmi -mthumb-interwork")
  set(NDS_LINK_FLAGS "-specs=ds_arm7.specs")
endif()
