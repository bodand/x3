#!/usr/bin/env cmake -P

cmake_minimum_required(VERSION 3.20)

## CONFIGURATION VARIABLES #############################################################################################
#
# Many variables may be passed to bootstrap.cmake to configure its behavior. These are used as basic CMake variables
# and may be passed using standard -DVAR=VALUE syntax BEFORE THE -P COMMAND LINE FLAG to CMake.
# If configuration is needed, you'll need to explicitly call cmake on Unices instead of relying on the shebang:
#    cmake -DVAR1=VALUE -DVAR3=1 -P bootstrap.cmake
#
# The following list of variables are understood (please keep this list up-to-date, because no-one wants to read CMake
# code to find random variables):
#  - X3_GITHUB_MIRROR:BOOL -- Whether to enable fossil's ability to export to git repositories
#  - X3_GITHUB_DIRECTORY:PATH -- A directory where the local git checkout will be stored, defaults to a sibling of the
#                                current project's directory with a `-git` suffix.
#  - X3_GITHUB_CREDENTIALS:STRING -- The credentials to send to github; either username:password or access token. This
#                                    variable will be looked up in environment variables as well, if not defined
#                                    explicitly.
#  - X3_GITHUB_URL:STRING -- The remote git repository's URL, without URL schema. This repo must be accessible using
#                            https. For example: for https://github.com/bodand/x3 this variable should contain
#                            github.com/bodand/x3.
# - X3_FOSSIL_COMMAND:FILEPATH -- The fossil executable to use. Defaults to first found `fossil` executable.

## SCRIPT BODY #########################################################################################################

## finding fossil executable ##
message(CHECK_START "Searching for fossil executable... ")
if (NOT X3_FOSSIL_COMMAND STREQUAL "")
    find_program(_FossilExe fossil)
    if (_FossilExe)
        message(CHECK_PASS "${_FossilExe}")
    else ()
        message(CHECK_FAIL "not found")
        message(FATAL_ERROR "Without fossil nothing will work. How did you even clone this repo w/o it?
Also, a note for those who have not read the README: you only need to run bootstrap.cmake if you want to contribute to
x3. For a simply building and using the library, none of this is needed.")
    endif ()

    set(X3_FOSSIL_COMMAND "${_FossilExe}")
else ()
    message(CHECK_PASS "provided: ${X3_FOSSIL_COMMAND}")
endif ()

## GitHub Mirroring ##

# If X3_GITHUB_MIRROR is set to true (false by default), a git mirror using fossil will be created.
# By default this is at the directory ../x3-git (as absolute path) if project's checkout directory is x3, but can be
# overwritten using the X3_GITHUB_DIRECTORY setting.
# The variable X3_GITHUB_CREDENTIALS is either supplied or read from environment variables, and will be used to
# authenticate to github. (either `username:password` or an access token with repo privileges)
if (DEFINED X3_GITHUB_MIRROR
        AND X3_GITHUB_MIRROR)
    message(STATUS "GitHub mirroring enabled...")
    if (NOT DEFINED X3_GITHUB_DIRECTORY)
        message(STATUS "GitHub mirror directory not defined... calculating")
        cmake_path(GET CMAKE_CURRENT_SOURCE_DIR PARENT_PATH AboveX3Root)
        cmake_path(GET CMAKE_CURRENT_SOURCE_DIR FILENAME X3DirName)

        set(X3_GITHUB_DIRECTORY "${AboveX3Root}/${X3DirName}-git")
    endif ()

    message(CHECK_START "GitHub mirror directory is ${X3_GITHUB_DIRECTORY}...")
    if (NOT IS_DIRECTORY "${X3_GITHUB_DIRECTORY}")
        file(MAKE_DIRECTORY "${X3_GITHUB_DIRECTORY}")
        message(CHECK_FAIL "created")
    else ()
        message(CHECK_PASS "already exists... hopefully nothing breaks")
    endif ()

    message(CHECK_START "Checking fossil hooks for git export...")
    execute_process(COMMAND "${X3_FOSSIL_COMMAND}" hook list
            OUTPUT_VARIABLE fsl_hooks_list
            WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")
    if (fsl_hooks_list MATCHES [[command = %F git export -R %R]])
        message(CHECK_PASS "present")
    else ()
        message(CHECK_FAIL "missing")

        message(CHECK_START "Creating fossil initial git export (may take some time)...")
        execute_process(COMMAND "${X3_FOSSIL_COMMAND}" git export
                "${X3_GITHUB_DIRECTORY}"
                "https://${X3_GITHUB_CREDENTIALS}@${X3_GITHUB_URL}"
                WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")

        message(CHECK_START "Creating fossil hook for git export...")
        execute_process(COMMAND "${X3_FOSSIL_COMMAND}" hook add --type "after-receive" --command "%F git export -R %R"
                RESULT_VARIABLE fsl_result)
        if (fsl_result EQUAL 0)
            message(CHECK_PASS "done")
        else ()
            message(CHECK_PASS "failed: fossil exited with exit code ${fsl_result}")
            message(SEND_ERROR "Could not create after-receive git export hook.")
        endif ()
    endif ()
endif ()

message(STATUS "Bootstrapping directory ${CMAKE_CURRENT_SOURCE_DIR}")