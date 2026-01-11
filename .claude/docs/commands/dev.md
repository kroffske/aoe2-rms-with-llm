# dev/* Commands

Code quality and development tooling.

**Note:** For code review, use `/validation reviewer`. For refactoring, use `refactor` skill.

## Quick Reference

| Command | Output | Modifies code? |
|---------|--------|----------------|
| `/dev:lint` | Pass/fail | No |

---

## /dev:lint

**Run all quality gates** in one command.

```
/dev:lint
    |
    +---> ruff check
    +---> ruff format --check
    +---> standards-lint (if exists)
    +---> pytest (if exists)
    |
    v
  Pass / Fail report
```

**When to use:**
- Before commit
- Quick quality check
- CI-like local validation

---
