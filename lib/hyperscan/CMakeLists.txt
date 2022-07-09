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

include(FetchContent)

message("BOOST_ROOT: ${BOOST_ROOT}")
FetchContent_Declare(hyperscan
        URL https://github.com/intel/hyperscan/archive/refs/tags/v5.4.0.tar.gz
        URL_HASH SHA3_256=2faa74458dcb4c6244e4568babc45dd31669d02c3640ab1103c13aa203a30a9a
        PATCH_COMMAND "${CMAKE_COMMAND}" "-DWD=${CMAKE_BINARY_DIR}/_deps/hyperscan-src" -P "${CMAKE_CURRENT_SOURCE_DIR}/patch-hyperscan.cmake")
FetchContent_MakeAvailable(hyperscan)
add_dependencies(hs ragel)
