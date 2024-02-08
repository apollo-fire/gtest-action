# gtest_action
Docker Action that can build and execute Googletest cases

## Example usage
### Where source code is included in test directories
```yaml
- uses: apollo-fire/gtest-action@v0.0.5
  with:
    test-path: 'src/tests/drivers;src/tests/application'
```
### Where source code is separate to test directory
```yaml
- uses: apollo-fire/gtest-action@v0.0.5
  with:
    test-path: 'tests/'
    source-path: 'src/'
```
