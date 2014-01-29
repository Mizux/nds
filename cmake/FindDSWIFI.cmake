cmake_minimum_required(VERSION 2.8)

# LibDsWifi for arm7 or arm9
message(STATUS "Looking for dswifi...")
set(DSWIFI_INCLUDE_DIRS ${CMAKE_CURRENT_LIST_DIR}/../libnds/include)
message(STATUS "Looking for dswifi: ${DSWIFI_INCLUDE_DIRS} - found")

if(${DSWIFI_FIND_COMPONENTS} MATCHES ARM7)
  set(DSWIFI_LIBRARIES ${CMAKE_CURRENT_LIST_DIR}/../libnds/lib/libdswifi7.a)
endif()
if(${DSWIFI_FIND_COMPONENTS} MATCHES ARM9)
  set(DSWIFI_LIBRARIES ${CMAKE_CURRENT_LIST_DIR}/../libnds/lib/libdswifi9.a)
endif()
