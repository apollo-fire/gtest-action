set(NAME tests)

add_executable(${NAME})
target_sources(${NAME} PRIVATE dummy-test.cpp)
target_include_directories(${NAME} PRIVATE ${TESTBED_INCLUDES} ${LOOP_DEVICE_INCLUDES} ${TEST_INCLUDES})
target_link_libraries(${NAME} PRIVATE gtest_main)
add_test(${NAME} ${NAME})
