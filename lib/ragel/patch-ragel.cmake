set(RAGEL_CMAKELISTS_TXT [==[
cmake_minimum_required(VERSION 3.20)

project(ragel
        VERSION 6.10)

set(PACKAGE "${PROJECT_NAME}")
set(PACKAGE_BUGREPORT "")
set(PACKAGE_NAME "${PROJECT_NAME}")
set(PACKAGE_STRING "${PROJECT_NAME} ${PROJECT_VERSION}")
set(PACKAGE_TARNAME "${PROJECT_NAME}")
set(PACKAGE_URL "")
set(PACKAGE_VERSION "${PROJECT_VERSION}")
set(VERSION "${PROJECT_VERSION}")

configure_file(ragel/config.h.cmakein
        config.h)

add_executable(ragel
        ragel/cdcodegen.cpp
        ragel/cdfflat.cpp
        ragel/cdfgoto.cpp
        ragel/cdflat.cpp
        ragel/cdftable.cpp
        ragel/cdgoto.cpp
        ragel/cdipgoto.cpp
        ragel/cdsplit.cpp
        ragel/cdtable.cpp
        ragel/common.cpp
        ragel/cscodegen.cpp
        ragel/csfflat.cpp
        ragel/csfgoto.cpp
        ragel/csflat.cpp
        ragel/csftable.cpp
        ragel/csgoto.cpp
        ragel/csipgoto.cpp
        ragel/cssplit.cpp
        ragel/cstable.cpp
        ragel/dotcodegen.cpp
        ragel/fsmap.cpp
        ragel/fsmattach.cpp
        ragel/fsmbase.cpp
        ragel/fsmgraph.cpp
        ragel/fsmmin.cpp
        ragel/fsmstate.cpp
        ragel/gendata.cpp
        ragel/gocodegen.cpp
        ragel/gofflat.cpp
        ragel/gofgoto.cpp
        ragel/goflat.cpp
        ragel/goftable.cpp
        ragel/gogoto.cpp
        ragel/goipgoto.cpp
        ragel/gotable.cpp
        ragel/gotablish.cpp
        ragel/inputdata.cpp
        ragel/javacodegen.cpp
        ragel/main.cpp
        ragel/mlcodegen.cpp
        ragel/mlfflat.cpp
        ragel/mlfgoto.cpp
        ragel/mlflat.cpp
        ragel/mlftable.cpp
        ragel/mlgoto.cpp
        ragel/mltable.cpp
        ragel/parsedata.cpp
        ragel/parsetree.cpp
        ragel/rbxgoto.cpp
        ragel/redfsm.cpp
        ragel/rlparse.cpp
        ragel/rlscan.cpp
        ragel/rubycodegen.cpp
        ragel/rubyfflat.cpp
        ragel/rubyflat.cpp
        ragel/rubyftable.cpp
        ragel/rubytable.cpp
        ragel/xmlcodegen.cpp
        )
target_include_directories(ragel PRIVATE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/aapl>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>)
]==])
set(RAGEL_CMAKE_CONFIG_H [==[
/* Something that has nothing to do with anything.
   Spawned from the deepest layer of hell, just to bring pain upon
   the mortals who wish to understand what the fuck I was doing here. */
/* Basically just bridging CMake bullshit to AutoTools bullshit. */

/* Name of package */
#define PACKAGE "@PACKAGE@"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT "@PACKAGE_BUGREPORT@"

/* Define to the full name of this package. */
#define PACKAGE_NAME "@PACKAGE_NAME@"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "@PACKAGE_STRING@"

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "@PACKAGE_TARNAME@"

/* Define to the home page for this package. */
#define PACKAGE_URL "@PACKAGE_URL@"

/* Define to the version of this package. */
#define PACKAGE_VERSION "@PACKAGE_VERSION@"

/* Version number of package */
#define VERSION "@VERSION@"
]==])

if (EXISTS "${WD}/CMakeLists.txt")
    return()
endif ()

# If on Windows with MSVC, remove unistd.h includes. Things seem to work properly without
if (MSVC) # Passed through
    file(RENAME "${WD}/ragel/main.cpp" "${WD}/ragel/main.cpp.old")
    file(STRINGS "${WD}/ragel/main.cpp.old" _OldMainFile)

    set(_NewMainFile)
    foreach (ln IN LISTS _OldMainFile)
        if (ln MATCHES [[unistd\.h]])
            # Ignore line
        else ()
            set(_NewMainFile "${_NewMainFile}\n${ln}")
        endif ()
    endforeach ()
    file(WRITE "${WD}/ragel/main.cpp" "${_NewMainFile}")
endif ()

file(WRITE "${WD}/CMakeLists.txt" "${RAGEL_CMAKELISTS_TXT}")
file(WRITE "${WD}/ragel/config.h.cmakein" "${RAGEL_CMAKE_CONFIG_H}")

file(WRITE "${WD}/.patch-done")
