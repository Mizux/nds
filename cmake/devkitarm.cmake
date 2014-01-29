################################
##  Define Cross compilation  ##
################################
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR arm-none-eabi)

set(DEVKITARM $ENV{DEVKITARM})
if(NOT DEVKITARM)
 message(STATUS "Please set DEVKITARM in your environment")
 set(DEVKITARM ${CMAKE_CURRENT_LIST_DIR}/../devkitARM)
 message(STATUS "DEVKITARM set to: ${DEVKITARM}")
endif(NOT DEVKITARM)

set(CMAKE_AS_COMPILER ${DEVKITARM}/bin/arm-none-eabi-as)
set(CMAKE_C_COMPILER ${DEVKITARM}/bin/arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER ${DEVKITARM}/bin/arm-none-eabi-g++)
set(CMAKE_FIND_ROOT_PATH ${DEVKITARM})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})
############################
## Default Configuration  ##
############################
set(C_WARNFLAGS
  #-Werror
  -Wall
  -Wextra
  -Wpointer-arith
  -Wcast-align
  #-ansi
  -pedantic
  -pedantic-errors)
foreach(arg ${C_WARNFLAGS})
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${arg}")
endforeach(arg ${C_WARNFLAGS})
set(CXX_WARNFLAGS
  ${C_WARNFLAGS}
  #-Wold-style-cast
  -Weffc++)
foreach(arg ${CXX_WARNFLAGS})
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${arg}")
endforeach(arg ${CXX_WARNFLAGS})

# Generic compile Flag (both arm)
set(C_FLAGS
  -fno-rtti
  -fno-exceptions
  -fomit-frame-pointer
  -ffast-math)
foreach(arg ${C_FLAGS})
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${arg}")
endforeach(arg ${C_FLAGS})
