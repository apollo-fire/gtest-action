# gtest_action
Docker Action that can build and execute Googletest cases

## Example usage
### Where source code is included in test directories
```yaml
- uses: apollo-fire/gtest-action@v0.0.6
  with:
    test-path: 'src/tests/drivers;src/tests/application'
```
### Where source code is separate to test directory
```yaml
- uses: apollo-fire/gtest-action@v0.0.6
  with:
    test-path: 'tests/'
    source-path: 'src/'
```
### Where build parallelisation is overridden
```yaml
- uses: apollo-fire/gtest-action@v0.0.6
  with:
    test-path: 'src/tests/drivers;src/tests/application'
    parallel-compilation-count: 4
```
