cmake_minimum_required(VERSION 2.8)

# LibMaxMod for arm7 or arm9
message(STATUS "Looking for mm...")
set(MM_INCLUDE_DIRS ${CMAKE_CURRENT_LIST_DIR}/../libnds/include)
message(STATUS "Looking for mm: ${MM_INCLUDE_DIRS} - found")

if(${MM_FIND_COMPONENTS} MATCHES ARM7)
  set(MM_LIBRARIES ${CMAKE_CURRENT_LIST_DIR}/../libnds/lib/libmm7.a)
endif()
if(${MM_FIND_COMPONENTS} MATCHES ARM9)
  set(MM_LIBRARIES ${CMAKE_CURRENT_LIST_DIR}/../libnds/lib/libmm9.a)
endif()
