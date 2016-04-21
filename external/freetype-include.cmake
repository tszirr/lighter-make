option(LIGHTER_USE_CLEARTYPE "Enable sub-pixel anti-aliased font rendering" ON)
add_subdirectory(${EXTERNAL_DIR}/freetype ${EXTERNAL_BINARY_DIR}/freetype EXCLUDE_FROM_ALL)
if (LIGHTER_USE_CLEARTYPE)
	target_compile_definitions(freetype PRIVATE FT_CONFIG_OPTION_SUBPIXEL_RENDERING TT_CONFIG_OPTION_SUBPIXEL_HINTING)
endif()
target_compile_definitions(freetype PUBLIC GLEW_STATIC)
target_include_directories(freetype INTERFACE ${EXTERNAL_DIR}/freetype/include)
list(APPEND EXTERNAL_TARGETS freetype)