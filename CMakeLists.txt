cmake_minimum_required(VERSION 3.0.0)

# prevent recursive including by subprojects if used as collective cmake
if(LIGHTER_MAKE_INCLUDED)
  return()
endif()
set(LIGHTER_MAKE_INCLUDED true)

option(LIGHTER_INSTALL "Generate installation target" ON)

set_property(GLOBAL PROPERTY USE_FOLDERS On)

include(CMakeDependentOption)
include("cmake/PrecompiledHeader.cmake")
include("cmake/AddExternals.cmake")

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
