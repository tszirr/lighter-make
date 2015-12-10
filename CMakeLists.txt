cmake_minimum_required(VERSION 2.8.12)

include(CMakeDependentOption)
include("cmake/PrecompiledHeader.cmake")
include("cmake/AddExternals.cmake")

add_externals(LIGHTER_EXTERNAL_TARGETS lighter-ext External)

message("-- Collecting projects")
file(GLOB projects *)
foreach(projekt ${projects})
	if(EXISTS ${projekt}/CMakeLists.txt)
		message("--> ${projekt}")
		add_subdirectory(${projekt})
	endif()
endforeach()
message("")
