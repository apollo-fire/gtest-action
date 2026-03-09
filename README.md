# gtest_action

Docker Action that can build and execute Googletest cases

## Dependency management

GoogleTest is managed via [vcpkg](https://vcpkg.io). The `vcpkg.json` manifest at the repository root declares GoogleTest as a dependency. [Dependabot](https://docs.github.com/en/code-security/dependabot) is configured to automatically track and update this dependency.

### Installing dependencies with vcpkg

1. [Install vcpkg](https://learn.microsoft.com/en-us/vcpkg/get_started/get-started) and set `VCPKG_ROOT` to its installation directory.
2. Install dependencies:
   ```sh
   vcpkg install
   ```
3. Build with the vcpkg toolchain:
   ```sh
   cmake CMakeLists.txt -DCMAKE_TOOLCHAIN_FILE="$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake"
   make
   ```

> **Note:** If `VCPKG_ROOT` is set in your environment, the CMakeLists.txt files in this project will automatically detect and use the vcpkg toolchain.

## Example usage

### Where source code is included in test directories

```yaml
- uses: apollo-fire/gtest-action@v0.0.9
  with:
    test-path: "src/tests/drivers;src/tests/application"
```

### Where source code is separate to test directory

```yaml
- uses: apollo-fire/gtest-action@v0.0.9
  with:
    test-path: "tests/"
    source-path: "src/"
```

### Where build parallelisation is overridden

```yaml
- uses: apollo-fire/gtest-action@v0.0.9
  with:
    test-path: "src/tests/drivers;src/tests/application"
    parallel-compilation-count: 4
```

### Where tests should be run in a shuffled order 10 times

```yaml
- uses: apollo-fire/gtest-action@v0.0.9
  with:
    test-path: "src/tests/drivers;src/tests/application"
    parallel-compilation-count: 4
    shuffle-count: 10
```
