cmake_minimum_required(VERSION 3.21)
project(example-unit-test_project CXX C)

# use C++20 standard
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 20)

set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "" FORCE)

# Optimisations and debugging info
add_compile_options(
  -fno-inline # Don't inline functions
  -g3 # Maximum debug info
  -O0 # No optimisation
  --coverage # Generate coverate report
)
add_link_options(--coverage)

# build GoogleTest from external source
if(NOT ${CMAKE_VERSION} VERSION_LESS "3.24")
  cmake_policy(SET CMP0135 NEW)
endif()

include(FetchContent)
FetchContent_Declare(
  googletest

  # release-1.10.0
  URL https://tinyurl.com/gtest-release-1-10-0
)

# for Windows: prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

# Compiler warnings
add_compile_options(

  # -pedantic                                             # Issue all the warnings demanded by strict ISO C and ISO C++; reject all programs that use forbidden extensions, and some other programs that do not follow ISO C and ISO C++
  -Wall # Base set of warnings generally agreed upon as being useful and easy to fix

  # -Wcast-align                                          # Warn about attempts to cast from types with smaller alignments to a types with larger alignments
  # -Wconversion                                          # Generate warnings when implicit conversions that are likely to change the underlying value take place
  -Wdouble-promotion # Detect implicit double promotion (Cortex-M only supports float precision in the hardware, using doubles hits performance and causes bloat. Always use 1.0f instead of 1.0, unless absolutely necessary)

  # -Wextra                                               # Additional set of flags not covered by -Wall
  -Wformat=2 -Wformat-truncation # Enable extra (s)printf formatting checks
  -Wlogical-op # Warn about suspicious uses of logical operators in expressions
  -Wno-comment # Disable warn about multi-line comments
  -Wno-unknown-pragmas # Disable unknown pragma warnings

  # -Wsign-conversion                                     # Warn about conversion between signed and unsigned integers
  -Wshadow # Detect shadowed variables
  -Wundef # Detect undefined macro usage. An undefined macro silently evaluates to 0. Detection is not possible when the check is preceded by the ifdef (anti-)pattern check.
  $<$<COMPILE_LANGUAGE:CXX>:-Wsuggest-final-types> # Warn about types with virtual methods where code quality would be improved if the type were declared with the C++11 final specifier, or, if possible, declared in an anonymous namespace
  $<$<COMPILE_LANGUAGE:CXX>:-Wsuggest-final-methods> # Warn about virtual methods where code quality would be improved if the method were declared with the C++11 final specifier, or, if possible, its type were declared in an anonymous namespace or with the final specifier
  $<$<COMPILE_LANGUAGE:CXX>:-Wsuggest-override> # Warn about overriding virtual functions that are not marked with the override keyword.
)

add_definitions(-DUNIT_TESTING)

# enable ctest
enable_testing()
set(CTEST_OUTPUT_ON_FAILURE ON)

# add library unit tests
add_subdirectory(tests)
