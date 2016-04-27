#--------------------------------------------------------------------
# Configuration
#--------------------------------------------------------------------
if(MSVC)
    option(USE_MSVC_RUNTIME_LIBRARY_DLL "Use MSVC runtime library DLL" OFF)
endif()

#--------------------------------------------------------------------
# Set compiler-specific flags (global)
#--------------------------------------------------------------------
if(MSVC)
	# Mute deprecation warnings
    add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_SCL_SECURE_NO_WARNINGS)
	
	# More memory, better debuggability
    add_compile_options(-Zm256 -d2Zi+)
	
	# Allow static runtime
    if (NOT USE_MSVC_RUNTIME_LIBRARY_DLL)
	    set(COMPILER_FLAG_VARIABLES CMAKE_C_FLAGS CMAKE_CXX_FLAGS)
		foreach(FLAG_VAR ${COMPILER_FLAG_VARIABLES})
		    foreach(CFG ${CMAKE_CONFIGURATION_TYPES})
                 string(TOUPPER "${CFG}" CFG_UPPER)
	             list(APPEND COMPILER_FLAG_VARIABLES "${FLAG_VAR}_${CFG_UPPER}")
		    endforeach()
		endforeach()
		
        foreach (flag ${COMPILER_FLAG_VARIABLES})
            if (${flag} MATCHES "/MD")
                string(REGEX REPLACE "/MD" "/MT" ${flag} "${${flag}}")
            endif()
            if (${flag} MATCHES "/MDd")
                string(REGEX REPLACE "/MDd" "/MTd" ${flag} "${${flag}}")
            endif()
        endforeach()
    endif()
	
else()
	# Default to private symbols
	add_definitions(-fvisibility=hidden)
endif()

if (UNIX)
	set(LIGHTER_MAKE_DEFAULT_LIBS ${LIGHTER_MAKE_DEFAULT_LIBS} pthread X11 Xrandr Xi Xxf86vm Xcursor Xinerama)
endif()

set(LIGHTER_MAKE_GLOBAL_FLAGS_SET TRUE)