#!/bin/bash

# Args
# $1 paths to the unit test projects, delimited by ;
# $2 relative path to project under test's sourcecode
# $3 value to use for makes' j flag
# $4 number of times to run the tests

# Check if user has passed in an integer value
if ! [ "$3" -eq "$3" ] 2> /dev/null;
then
    # Automatically determine processing unit count
    CPU_COUNT=$(nproc)
    echo "Detected $CPU_COUNT processing units"
    if ! [ "$CPU_COUNT" -eq "$CPU_COUNT" ] 2> /dev/null;
    then
        echo "CPU_COUNT is not an integer"
        CPU_COUNT=1
    else
        CPU_COUNT=$((CPU_COUNT - 1))
    fi    
else
    echo "Requested $3 processing units"
    MAX_CPU=8
    # Use value passed in by user, throttled to MAX_CPU
    CPU_COUNT=$(($3 < MAX_CPU ? $3 : MAX_CPU))
fi
echo "Setting CPU_COUNT to $CPU_COUNT"

# Check if user has passed in an integer value
if ! [ "$4" -eq "$4" ] 2> /dev/null;
then
    SHUFFLE_COUNT=0
else
    SHUFFLE_MAX=1000
    SHUFFLE_COUNT=$(($4 < SHUFFLE_MAX ? $4 : SHUFFLE_MAX))
fi

# Split the delimited string into an array of paths
IFS=';' read -ra paths <<< "$1"

for i in "${paths[@]}"; do
  echo "processing unit tests in: $i"
  
  # Check if CMakeLists.txt already exists in the unit test directory
  if [ ! -e "$i/CMakeLists.txt" ]; then
    cp /CMakeLists.txt "$i"
  fi

  pushd "$i" || exit 1
  cmake CMakeLists.txt  
  make -j "$CPU_COUNT" || exit 2

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
    if [ "$SHUFFLE_COUNT" -gt 0 ] 2> /dev/null;
    then
      echo "shuffling tests $SHUFFLE_COUNT times"
      "$executable" --gtest_shuffle --gtest_repeat="$SHUFFLE_COUNT"
    fi

    # only run once through valgrind due to the additional overhead
    valgrind --leak-check=full --error-exitcode=4 "$executable" || exit 4
  done

  # determine source dir
  if [ -z "$2" ]; then
    source_dir="."
  else
    source_dir=$2
  fi

  # generate a coverage report
  uuid=$(uuidgen)
  gcovr . --root "$source_dir"  --branches --xml-pretty >> "$uuid-report.xml"
done
