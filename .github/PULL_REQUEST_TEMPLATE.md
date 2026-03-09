## Description

<!-- Describe the changes in this PR and why they are needed. -->

## PR Title Checklist

> [!IMPORTANT]
> The PR title **must** follow the [Conventional Commits](https://www.conventionalcommits.org/) format.
> It is used as the squash-merge commit message onto `main`.

**Format:** `<type>: <description>`

**Supported types:** `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `revert`

**Examples:**

- `feat: add shuffle support for randomized test execution`
- `fix: correct exit code handling in entrypoint script`
- `docs: update README with installation instructions`
- `ci: add CodeQL security scanning workflow`
- `refactor: simplify Docker image build process`
- `test: add integration tests for vcpkg dependencies`

## Checklist

- [ ] PR title follows the Conventional Commits format
- [ ] Changes are covered by tests (new or existing)
- [ ] All CI checks pass
- [ ] Documentation updated if required (e.g. `README.md`, `action.yml` descriptions)
- [ ] No secrets or sensitive data committed
