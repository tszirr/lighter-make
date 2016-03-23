# prevent recursive including
if(LIGHTER_INSTALL_COMMAND)
  return()
endif()

#--------------------------------------------------------------------
# Installation
#--------------------------------------------------------------------
if (CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX "${PROJECT_BINARY_DIR}/../deploy" CACHE PATH "Install path" FORCE)
	message(${CMAKE_INSTALL_PREFIX})
endif()

if (NOT LIGHTER_INSTALL_DATA_DIRECTORY)
    set(LIGHTER_INSTALL_DATA_DIRECTORY bin/data CACHE STRING "Data install directory")
endif()

set(LIGHTER_INSTALL_COMMAND ${CMAKE_COMMAND} -DBUILD_TYPE=$<CONFIGURATION> -P cmake_install.cmake WORKING_DIRECTORY ${PROJECT_BINARY_DIR})
