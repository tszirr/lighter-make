define_property(SOURCE PROPERTY LIGHTER_INTERNAL_PCH_BIN_NAME BRIEF_DOCS PCH binary name FULL_DOCS PCH binary name)

function(get_precompiled_header_binary PCH_BIN_VAR PCH)
#  get_property(PCH_BIN SOURCE ${PCH} PROPERTY LIGHTER_INTERNAL_PCH_BIN_NAME)
#  if (NOT ${PCH_BIN})
#    message(FATAL_ERROR "PCH ${PCH} needs to be added before first use")
#  endif()
  get_filename_component(PCH_BASE ${PCH} NAME_WE)
  set(${PCH_BIN_VAR} ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/${PCH_BASE}.pch PARENT_SCOPE)
endfunction()

function(add_precompiled_header PCH PCH_SRC)
  if(MSVC)
    get_filename_component(PCH_BASE ${PCH} NAME_WE)
    set(PCH_BIN ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/${PCH_BASE}.pch)
    
#   set_property(SOURCE ${PCH} ${PCH_SRC} PROPERTY LIGHTER_INTERNAL_PCH_BIN_NAME ${PCH_BIN})
	
    set_source_files_properties(${PCH_SRC}
                                PROPERTIES COMPILE_FLAGS -Yc${PCH}
                                           OBJECT_OUTPUTS ${PCH_BIN})                 
  endif()
endfunction()

function(target_precompiled_header TARGET PCH PCH_SRC)
  add_precompiled_header(${PCH} ${PCH_SRC})
  if(MSVC)
    get_precompiled_header_binary(PCH_BIN ${PCH})
    target_compile_options(${TARGET} PRIVATE -Yu${PCH} -FI${PCH} -Fp${PCH_BIN})           
  endif()
endfunction()

function(use_precompiled_header PCH)
  if(MSVC)
    get_precompiled_header_binary(PCH_BIN ${PCH})
    set_property(SOURCE ${ARGN} APPEND PROPERTY COMPILE_FLAGS -Yu${PCH} -FI${PCH} -Fp${PCH_BIN})           
  endif()
endfunction()
