##  Copyright (c) 2012-2019 Leonid Yuriev <leo@yuriev.ru>.
##
##  Licensed under the Apache License, Version 2.0 (the "License");
##  you may not use this file except in compliance with the License.
##  You may obtain a copy of the License at
##
##      http://www.apache.org/licenses/LICENSE-2.0
##
##  Unless required by applicable law or agreed to in writing, software
##  distributed under the License is distributed on an "AS IS" BASIS,
##  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##  See the License for the specific language governing permissions and
##  limitations under the License.
##

cmake_minimum_required(VERSION 3.8.2)
cmake_policy(PUSH)
cmake_policy(VERSION 3.8.2)

include(CheckLibraryExists)
check_library_exists(gcov __gcov_flush "" HAVE_GCOV)

option(ENABLE_GCOV
  "Enable integration with gcov, a code coverage program" OFF)

option(ENABLE_GPROF
  "Enable integration with gprof, a performance analyzing tool" OFF)

if(CMAKE_CXX_COMPILER_LOADED)
  include(CheckIncludeFileCXX)
  check_include_file_cxx(valgrind/memcheck.h HAVE_VALGRIND_MEMCHECK_H)
else()
  include(CheckIncludeFile)
  check_include_file(valgrind/memcheck.h HAVE_VALGRIND_MEMCHECK_H)
endif()

option(ENABLE_VALGRIND "Enable integration with valgrind, a memory analyzing tool" OFF)
if(ENABLE_VALGRIND AND NOT HAVE_VALGRIND_MEMCHECK_H)
  message(FATAL_ERROR "ENABLE_VALGRIND option is set but valgrind/memcheck.h is not found")
endif()

option(ENABLE_ASAN
  "Enable AddressSanitizer, a fast memory error detector based on compiler instrumentation" OFF)

cmake_policy(POP)
