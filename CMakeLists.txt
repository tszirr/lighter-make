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

#--------------------------------------------------------------------
# Installation
#--------------------------------------------------------------------
if (CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX "${PROJECT_BINARY_DIR}/../deploy" CACHE PATH "Install path" FORCE)
endif()

if (NOT LIGHTER_INSTALL_DATA_DIRECTORY)
    set(LIGHTER_INSTALL_DATA_DIRECTORY bin/data CACHE STRING "Data install directory")
endif()

set(LIGHTER_INSTALL_COMMAND ${CMAKE_COMMAND} -DBUILD_TYPE=$<CONFIGURATION> -P cmake_install.cmake WORKING_DIRECTORY ${PROJECT_BINARY_DIR} PARENT_SCOPE)

#--------------------------------------------------------------------
# Setup
#--------------------------------------------------------------------

set_property(GLOBAL PROPERTY USE_FOLDERS On)

include(CMakeDependentOption)
include("cmake/PrecompiledHeader.cmake")
include("cmake/AddExternals.cmake")

#--------------------------------------------------------------------
# Assemble project
#--------------------------------------------------------------------

project(light-all)

add_externals(LIGHTER_EXTERNAL_TARGETS ../external external External)

set(LIGHTER_IMPORT_SRC ON)

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
