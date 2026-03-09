# Pull Request

## Description

<!-- Describe the changes in this PR and why they are needed. -->

## PR Title Checklist

> [!IMPORTANT]
> The PR title **must** follow the [Conventional Commits](https://www.conventionalcommits.org/) format.
> It is used as the squash-merge commit message onto `main`.

**Format:** `<type>[optional scope][!]: <description>`

**Supported types:** `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `revert`

**Examples:**

- `feat: add shuffle support for randomized test execution`
- `feat(api): add shuffle support for randomized test execution`
- `feat(api)!: change shuffle behavior to be opt-out instead of opt-in`
- `fix: correct exit code handling in entrypoint script`
- `docs: update README with installation instructions`
- `ci: add CodeQL security scanning workflow`

## Checklist

- [ ] PR title follows the Conventional Commits format
- [ ] Changes are covered by tests (new or existing), if applicable (otherwise mark as N/A)
- [ ] All CI checks pass
- [ ] Documentation updated, if applicable (e.g. `README.md`, `action.yml` descriptions; otherwise mark as N/A)
- [ ] No secrets or sensitive data committed
