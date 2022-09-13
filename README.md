# gtest_action
Docker Action that can build and execute Googletest cases

## Example usage
```yaml
- uses: apollo-fire/gtest-action@v0.0.3
  with:
    test-paths: 'src/tests/drivers;src/tests/application'      
```
