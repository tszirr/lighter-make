#--------------------------------------------------------------------
# Set compiler-specific flags (local)
#--------------------------------------------------------------------
if(MSVC)

else()
	add_definitions(-std=c++11)
endif()
