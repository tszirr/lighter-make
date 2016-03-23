cmake_minimum_required(VERSION 3.0.0)

# prevent recursive including by subprojects if used as collective cmake
if(LIGHTER_MAKE_INCLUDED)
  return()
endif()
set(LIGHTER_MAKE_INCLUDED true)

#--------------------------------------------------------------------
# Configuration
#--------------------------------------------------------------------

option(LIGHTER_INSTALL "Generate installation target" ON)

if (MSVC)
    option(USE_MSVC_RUNTIME_LIBRARY_DLL "Use MSVC runtime library DLL" OFF)
endif()

#--------------------------------------------------------------------
# Setup
#--------------------------------------------------------------------

set_property(GLOBAL PROPERTY USE_FOLDERS On)

include("install-config.cmake")
include(CMakeDependentOption)
include("cmake/PrecompiledHeader.cmake")
include("cmake/AddExternals.cmake")

if (CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_LIST_DIR)
	include("global-flags.cmake")
endif()

#--------------------------------------------------------------------
# Assemble project
#--------------------------------------------------------------------

project(light-all)

add_externals(LIGHTER_EXTERNAL_TARGETS ../external external External)

set(LIGHTER_IMPORT_SRC ON)

if (LIGHTER_MAKE_GLOBAL_FLAGS_SET)
	include("global-flags-internal.cmake")
endif()

get_filename_component(PROJECT_DIR .. ABSOLUTE)
message("-- Collecting projects")
file(GLOB projects RELATIVE ${PROJECT_DIR} ${PROJECT_DIR}/*)
foreach(projekt ${projects})
	set(project_dir ${PROJECT_DIR}/${projekt})
	if(EXISTS ${project_dir}/CMakeLists.txt)
		message("--> ${project_dir}")
		add_subdirectory(${project_dir} projects/${projekt})
	endif()
endforeach()
message("")
