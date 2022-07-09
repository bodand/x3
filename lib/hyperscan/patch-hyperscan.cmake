if (EXISTS "${WD}/.patch-done3")
    return()
endif ()

# PATCH CMakeLists.txt
file(RENAME "${WD}/CMakeLists.txt" "${WD}/CMakeLists.txt.old")
file(STRINGS "${WD}/CMakeLists.txt.old" _OldCMFile)

file(WRITE "${CMAKE_BINARY_DIR}/empty-do-not-remove")

set(_NewCMFile)
foreach (ln IN LISTS _OldCMFile)
    if (ln MATCHES [[INPUT_FILE /dev/null]])
        set(_NewCMFile "${_NewCMFile}\nINPUT_FILE \"${CMAKE_BINARY_DIR}/empty-do-not-remove\"")
    elseif (ln MATCHES [[-Werror]])
        # skip, not-disableable -Werror is stupid design anyways
    else ()
        set(_NewCMFile "${_NewCMFile}\n${ln}")
    endif ()
endforeach ()
file(WRITE "${WD}/CMakeLists.txt" "${_NewCMFile}")


# PATCH src/util/flat_containers.h
file(RENAME "${WD}/src/util/flat_containers.h" "${WD}/src/util/flat_containers.h.old")
file(STRINGS "${WD}/src/util/flat_containers.h.old" _OldFlatCFile)

file(WRITE "${CMAKE_BINARY_DIR}/empty-do-not-remove")

set(_NewFlatCFile)
set(_ln_cnt 1)
foreach (ln IN LISTS _OldFlatCFile)
    if (_ln_cnt EQUAL 40)
        set(_NewFlatCFile "${_NewFlatCFile}\n${ln}\n#include <stdexcept>")
    else ()
        set(_NewFlatCFile "${_NewFlatCFile}\n${ln}")
    endif ()
    math(EXPR _ln_cnt "${_ln_cnt} + 1")
endforeach ()
file(WRITE "${WD}/src/util/flat_containers.h" "${_NewFlatCFile}")


file(WRITE "${WD}/.patch-done3")