#!/bin/bash

# Args
# $1 paths to the unit test projects, delimited by ;

# Split the delimited string into an array of paths
IFS=';' read -ra paths <<< "$1"

for i in "${paths[@]}"; do
  echo "processing unit tests in: $i"
  
  cp /CMakeLists.txt "$i"
  pushd "$i" || exit 1
  cmake CMakeLists.txt
  make || exit 2

  # execute the unit tests
  popd || exit 3
  "./$i/unit_tests" || exit 4

  # generate a coverage report
  uuid=$(uuidgen)
  gcovr --branches --xml-pretty -r . >> "$uuid-report.xml"
done
