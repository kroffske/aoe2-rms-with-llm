# release/* Commands

Git workflow and versioning.

**Note:** For changelog generation, use `changelog` skill.

## Flow

```
Code changes
    |
    v
/release:commit    (atomic commits)
    |
    v
/release:push      (tag + push)
```

---

## /release:commit

**Create conventional commit.**

```
/release:commit
    |
    v
  Analyze staged changes
    |
    v
  Generate message:
  - feat: new feature
  - fix: bug fix
  - chore: maintenance
  - docs: documentation
    |
    v
  Commit with footer:
  "Generated with Claude Code"
```

**Format:**
```
feat(auth): add OAuth2 login

- Add Google provider
- Add token refresh logic

Generated with Claude Code
Co-Authored-By: Claude ...
```

**When to use:**
- After completing logical unit of work
- Want consistent commit messages

---

## /release:push

**Full release workflow.**

```
/release:push [--bump patch|minor|major]
    |
    +---> Bump version in pyproject.toml
    +---> Generate changelog
    +---> Create git tag
    +---> Push to remote
    |
    v
  Release complete!
```

**When to use:**
- Ready to release
- All changes committed
- Tests passing
