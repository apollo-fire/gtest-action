#!/bin/bash

# Args
# $1 paths to the unit test projects, delimited by ;

# Split the delimited string into an array of paths
IFS=';' read -ra paths <<< "$1"

for i in "${paths[@]}"; do
  echo "processing unit tests in: $i"
  
  # Check if CMakeLists.txt already exists in the unit test directory
  if [ ! -e "$i/CMakeLists.txt" ]; then
    cp /CMakeLists.txt "$i"
  fi

  pushd "$i" || exit 1
  cmake -DCMAKE_CXX_FLAGS="--coverage" CMakeLists.txt
  make || exit 2

  # Find all executables ending in _tests recursively in the specified root directory
  popd || exit 3
  mapfile -t test_executables < <(find "$i" -type f -executable -name "*_tests")

  # Check if any test executables were found
  if [ ${#test_executables[@]} -eq 0 ]; then
    echo "no test executables found"
    exit 4
  fi

  # execute the unit tests
  for executable in "${test_executables[@]}"; do
    valgrind --leak-check=full --error-exitcode=4 "$executable" || exit 4
  done

  # generate a coverage report
  uuid=$(uuidgen)
  gcovr --branches --xml-pretty -r . >> "$uuid-report.xml"
done
