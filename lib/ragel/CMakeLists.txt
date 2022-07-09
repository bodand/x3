## -- x3 project --
#
# Copyright (c) 2022 András Bodor <bodand@pm.me>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# - Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# - Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# - Neither the name of the copyright holder nor the names of its contributors
#   may be used to endorse or promote products derived from this software
#   without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

project(x3-ragel
        VERSION 6.10)

include(FetchContent)

FetchContent_Declare(Ragel
        URL https://www.colm.net/files/ragel/ragel-6.10.tar.gz
        URL_HASH SHA3_256=16845c8554b29c05f3b2136ff26c3b71e93d6d48968153dabef2ede2a11c59a4
        PATCH_COMMAND "${CMAKE_COMMAND}" "-DWD=${CMAKE_BINARY_DIR}/_deps/ragel-src" "-DMSVC=${MSVC}" -P "${CMAKE_CURRENT_SOURCE_DIR}/patch-ragel.cmake")
FetchContent_MakeAvailable(Ragel)
