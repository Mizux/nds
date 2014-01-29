cmake_minimum_required(VERSION 2.8)

#############
##  BIN2S  ##
#############
if(NOT BIN2S)
	message(STATUS "Looking for grit...")
	find_program(BIN2S bin2s ${DEVKITARM}/bin)
	if(BIN2S)
		message(STATUS "Looking for grit: ${BIN2S} - found")
	else(BIN2S)
		message(FATAL_ERROR "Looking for grit: ${BIN2S} - not found")
	endif(BIN2S)
endif(NOT BIN2S)

############
##  GRIT  ##
############
if(NOT GRIT)
	message(STATUS "Looking for grit...")
	find_program(GRIT grit ${DEVKITARM}/bin)
	if(GRIT)
		message(STATUS "Looking for grit: ${GRIT} - found")
	else(GRIT)
		message(FATAL_ERROR "Looking for grit: ${GRIT} - not found")
	endif(GRIT)
endif(NOT GRIT)

###############
##  NDSTOOL  ##
###############
if(NOT NDSTOOL)
	message(STATUS "Looking for ndstool...")
	find_program(NDSTOOL ndstool ${DEVKITARM}/bin)
	if(NDSTOOL)
		message(STATUS "Looking for ndstool: ${NDSTOOL} - found")
	else(NDSTOOL)
		message(FATAL_ERROR "Looking for ndstool: ${NDSTOOL} - not found")
	endif(NDSTOOL)
endif(NOT NDSTOOL)

####################
##  DEFAULT_ARM7  ##
####################
if(NOT DEFAULT_ARM7)
	message(STATUS "Looking for default_arm7...")
  find_program(DEFAULT_ARM7 default.elf ${DEVKITARM})
  if(DEFAULT_ARM7)
    message(STATUS "Looking for default_arm7: ${DEFAULT_ARM7} - found")
  else(DEFAULT_ARM7)
    message(FATAL_ERROR "Looking for ndstool: ${DEFAULT_ARM7} - not found")
  endif(DEFAULT_ARM7)
endif(NOT DEFAULT_ARM7)

#############
##  MACRO  ##
#############

# ELF -> .bin
macro(CONVERT_TO_BIN NAME)
	add_custom_command(TARGET ${NAME}
		POST_BUILD
		COMMAND ${CMAKE_OBJCOPY}
		ARGS -O binary ${NAME} ${NAME}.bin
		COMMENT "${NAME} -> ${NAME}.bin"
		)
	set_directory_properties(PROPERTIES
		ADDITIONAL_MAKE_CLEAN_FILES ${NAME}.bin)
endmacro(CONVERT_TO_BIN)

# .bin -> .nds
macro(CONVERT_TO_NDS NAME)
	add_custom_command(TARGET ${NAME}
		POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/bin
		COMMAND ${NDSTOOL}
		-c ${CMAKE_BINARY_DIR}/bin/${NAME}.nds
		-9 ${NAME}.bin
    -7 ${DEFAULT_ARM7}
		COMMENT "${NAME}.bin -> ${NAME}.nds"
		)
	set_directory_properties(PROPERTIES
		ADDITIONAL_MAKE_CLEAN_FILES ${CMAKE_BINARY_DIR}/bin/${NAME}.nds)
endmacro(CONVERT_TO_NDS)

# arm7.bin arm9.bin -> .nds
macro(CONVERT_COMBINED_TO_NDS ARM7_NAME ARM9_NAME NAME)
	add_custom_command(TARGET ${NAME}
		POST_BUILD
		COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/bin
		COMMAND ${NDSTOOL}
		-c ${CMAKE_BINARY_DIR}/bin/${NAME}.nds
		-9 arm9/${ARM9_NAME}.bin
		-7 arm7/${ARM7_NAME}.bin
		COMMENT "arm7/${ARM7_NAME}.bin arm9/${ARM9_NAME}.bin -> ${NAME}.nds"
		)
	set_directory_properties(PROPERTIES
		ADDITIONAL_MAKE_CLEAN_FILES ${CMAKE_BINARY_DIR}/bin/${NAME}.nds)
endmacro(CONVERT_COMBINED_TO_NDS)

macro(NDSTOOL_FILES arm7_NAME arm9_NAME exe_NAME)
	set(FO ${CMAKE_CURRENT_BINARY_DIR}/${exe_NAME}.nds)
	set(I9 ${CMAKE_CURRENT_BINARY_DIR}/${arm9_NAME}.bin)
	set(I7 ${CMAKE_CURRENT_BINARY_DIR}/${arm7_NAME}.bin)
	add_custom_command(
		OUTPUT ${FO}
		COMMAND ${NDSTOOL}
		ARGS -c ${FO} -9 ${I9} -7 ${I7})
	get_filename_component(TGT "${exe_NAME}" NAME)
	get_filename_component(TGT7 "${arm7_NAME}" NAME)
	get_filename_component(TGT9 "${arm9_NAME}" NAME)
	add_custom_target("Target97_${TGT}" ALL DEPENDS ${FO} VERBATIM)
	add_dependencies("Target97_${TGT}"
		"TargetObjCopy_${TGT7}"
		"TargetObjCopy_${TGT9}")
	get_directory_property(extra_clean_files ADDITIONAL_MAKE_CLEAN_FILES)
	set_directory_properties(
		PROPERTIES
		ADDITIONAL_MAKE_CLEAN_FILES "${extra_clean_files};${FO}")
endmacro(NDSTOOL_FILES)
