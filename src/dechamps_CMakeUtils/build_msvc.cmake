set(DECHAMPS_CMAKEUTILS_DIR "${CMAKE_CURRENT_LIST_DIR}")

function(build_msvc)
	cmake_parse_arguments(BUILD_MSVC "" "SOURCE_DIR;BUILD_DIR;ARCH" "" ${ARGN})

	find_package(VisualStudio_VsDevCmd MODULE REQUIRED)
	find_package(VisualStudio_cmake MODULE REQUIRED)

	include(execute_process_or_die)

	# Used by build_msvc.bat
	set(ENV{DECHAMPS_CMAKEUTILS_VISUALSTUDIO_VSDEVCMD} "${VisualStudio_VsDevCmd_EXECUTABLE}")
	set(ENV{DECHAMPS_CMAKEUTILS_VISUALSTUDIO_CMAKE} "${VisualStudio_cmake_EXECUTABLE}")
	set(ENV{DECHAMPS_CMAKEUTILS_SOURCE_DIR} "${BUILD_MSVC_SOURCE_DIR}")
	set(ENV{DECHAMPS_CMAKEUTILS_ARCH} "${BUILD_MSVC_ARCH}")

	execute_process_or_die(
		COMMAND cmd /D /C "${DECHAMPS_CMAKEUTILS_DIR}/build_msvc.bat"
		WORKING_DIRECTORY "${BUILD_MSVC_BUILD_DIR}"
	)

	unset(ENV{DECHAMPS_CMAKEUTILS_VISUALSTUDIO_VSDEVCMD})
	unset(ENV{DECHAMPS_CMAKEUTILS_VISUALSTUDIO_CMAKE})
	unset(ENV{DECHAMPS_CMAKEUTILS_SOURCE_DIR})
	unset(ENV{DECHAMPS_CMAKEUTILS_ARCH})
endfunction()
