# cd to the tests directory
# run
#   $cmake CMakeLists.txt
#   $make
#   $./


cmake_minimum_required(VERSION 3.10)
project(unit_tests)
 
# locate required packages
find_package(GTest REQUIRED)
find_package(Threads REQUIRED)

# pull in the GTest include files
include_directories(${GTEST_INCLUDE_DIRS})

# Recursively search for *.cpp files
file(GLOB unittest_SRC "*.cpp")

# define UNIT_TESTING
add_definitions(-DUNIT_TESTING)
add_definitions(-fprofile-arcs -ftest-coverage )

# define the compiler options to be used
add_compile_options(-Wall -g3 -fPIC -pthread -lgtest_main -lgtest -lpthread)

# define the executable to be generated
add_executable(unit_tests ${unittest_SRC})

# Link 'unit_tests' the GTest library and the pthread library
target_link_libraries(unit_tests ${GTEST_LIBRARIES} pthread gcov)
