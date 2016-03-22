add_subdirectory(${EXTERNAL_DIR}/glew ${EXTERNAL_BINARY_DIR}/glew EXCLUDE_FROM_ALL)
target_compile_definitions(libglew_static PUBLIC GLEW_STATIC)
target_include_directories(libglew_static INTERFACE ${EXTERNAL_DIR}/glew/include)
list(APPEND EXTERNAL_TARGETS libglew_static)