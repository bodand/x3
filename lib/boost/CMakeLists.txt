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

# Clones the Boost sources, for we only need the headers

if (NOT IS_DIRECTORY "${CMAKE_BINARY_DIR}/lib/boost-src/boost_1_79_0")
    file(DOWNLOAD
            https://boostorg.jfrog.io/artifactory/main/release/1.79.0/source/boost_1_79_0.tar.gz
            "${CMAKE_BINARY_DIR}/boost-1.79.tar.gz"
            EXPECTED_HASH SHA3_256=da652097875064816a12b97a865ea15a2d3a466a9d55be2b83af3ff7b4a4fa92)
    file(ARCHIVE_EXTRACT INPUT "${CMAKE_BINARY_DIR}/boost-1.79.tar.gz"
            DESTINATION "${CMAKE_BINARY_DIR}/lib/boost-src/"
            VERBOSE)
endif ()

set(BOOST_ROOT "${CMAKE_BINARY_DIR}/lib/boost-src/boost_1_79_0" CACHE STRING "The root of boost sources to use")
