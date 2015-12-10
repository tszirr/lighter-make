cmake_minimum_required(VERSION 2.8.12)

set_property(GLOBAL PROPERTY USE_FOLDERS On)

include(CMakeDependentOption)
include("cmake/PrecompiledHeader.cmake")
include("cmake/AddExternals.cmake")

add_externals(LIGHTER_EXTERNAL_TARGETS lighter-ext External)

macro(add_lighter_dependencies TARGET_NAME)

endmacro()

macro(setup_lighter_compilation)
    list(APPEND COMPILE_DEFINITIONS ${LIGHTER_COMPILE_DEFINITIONS})
    include_directories(${LIGHTER_INCLUDE_DIRS})
endmacro()

function(copy_data_files DEST_TARGET TARGET_DATA_DIR SOURCE_DATA_DIR) # DATA_FILES
    foreach(DATA_FILE ${ARGN})
        add_custom_command(TARGET ${DEST_TARGET} PRE_BUILD
            COMMAND ${CMAKE_COMMAND} -E copy_if_different "${SOURCE_DATA_DIR}/${DATA_FILE}" "${TARGET_DATA_DIR}"
        )
    endforeach()
endfunction()

set(LIGHTER_IMPORT_SRC ON)
set(LIGHTER_TARGET_FACTORY "${PROJECT_SOURCE_DIR}/cmake/lighter-CMakeLists.txt")

message("-- Collecting projects")
file(GLOB projects *)
foreach(projekt ${projects})
	if(EXISTS ${projekt}/CMakeLists.txt)
		message("--> ${projekt}")
		add_subdirectory(${projekt})
	endif()
endforeach()
message("")

add_custom_target(testtarget DEPENDS glew_static lighter)
