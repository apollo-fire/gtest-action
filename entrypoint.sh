#!/bin/sh

# Args
# 1 - path to directory with test cases

# Record starting directory
cwd="$PWD"

# Build the unit tests
cp /CMakeLists.txt "$1"
cd "$1" || exit 1
cmake CMakeLists.txt
make || exit 2

# execute the unit tests
cd "$cwd" || exit 3
cp "$1/unit_tests" "$cwd"
./unit_tests || exit 4

# generate a coverage report
gcovr --branches --xml-pretty -r . >> gcovr-report.xml
