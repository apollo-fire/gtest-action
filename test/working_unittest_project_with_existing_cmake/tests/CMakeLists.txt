set(NAME dummy_tests)

add_executable(${NAME})
target_sources(${NAME} PRIVATE dummy-test.cpp)
target_link_libraries(${NAME} PRIVATE gtest_main)
add_test(${NAME} ${NAME})
