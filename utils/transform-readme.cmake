#!/usr/bin/env cmake -P

cmake_minimum_required(VERSION 3.20)

if (NOT CMAKE_ARGC EQUAL 5)
    message(FATAL_ERROR "Usage: cmake -P transform-readme.cmake <fossil_executable> <changelist_file>")
endif ()

set(_FossilExe "${CMAKE_ARGV3}")

find_program(_AsciidoctorExe asciidoctor REQUIRED)
find_program(_PandocExe pandoc REQUIRED)

file(STRINGS "${CMAKE_ARGV4}" AllThings)
foreach (ln IN LISTS AllThings)
    message("ln: ${ln}")
endforeach ()

file(STRINGS "${CMAKE_ARGV4}" FilesInCommit
        REGEX [[^EDITED README\.]])

message(STATUS "f: ${FilesInCommit}")

list(LENGTH FilesInCommit ReadmeCount)
if (ReadmeCount EQUAL 1)
    # one thing was changed, but not the other:
    list(GET FilesInCommit 0 ChangedReadme)
    if (ChangedReadme STREQUAL "EDITED README.md")
        message(SEND_ERROR
                "Modified README.md, this'll be overwritten. Edit README.adoc instead. -- check failed: outsmarting causality failure")
        execute_process(COMMAND "${_FossilExe}" revert README.md)
        return()
    elseif (ChangedReadme STREQUAL "EDITED README.adoc")
        message(SEND_ERROR
                "Modified README.adoc. Updating README.md to reflect the changes. Sit tight. -- check failed: broken dependency failure")
        execute_process(COMMAND "${_AsciidoctorExe}" -b docbook -o - "README.adoc"
                COMMAND "${_PandocExe}" -s -f docbook -t markdown_strict - -o "README.md")
    else ()
        message(FATAL_ERROR "Help! I'm not prepared for this: ${ChangedReadme}. -- check failed: incomprehensible failure")
    endif ()
elseif (ReadmeCount EQUAL 2)
    message("README properly updated -- check passed")
elseif (ReadmeCount EQUAL 0)
    message("README up-to-date -- check passed")
else ()
    message(FATAL_ERROR "Help! ${ReadmeCount} out of 2 things changed. That doesn't seem correct. -- check failed: algebraic failure")
endif ()
