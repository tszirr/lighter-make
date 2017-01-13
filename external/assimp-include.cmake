# ASSIMP peripherals require old DirectX SDK, therefore disable from the start
set(ASSIMP_BUILD_ASSIMP_TOOLS OFF CACHE BOOL "")
set(ASSIMP_BUILD_SAMPLES OFF CACHE BOOL "")
set(ASSIMP_BUILD_TESTS OFF CACHE BOOL "")
set(ASSIMP_BUILD_STATIC_LIB ON CACHE BOOL "") #todo whats default?
add_subdirectory(${EXTERNAL_DIR}/assimp ${EXTERNAL_BINARY_DIR}/assimp EXCLUDE_FROM_ALL)
target_include_directories(assimp INTERFACE $<BUILD_INTERFACE:${EXTERNAL_DIR}/assimp/include>)
list(APPEND EXTERNAL_TARGETS assimp)