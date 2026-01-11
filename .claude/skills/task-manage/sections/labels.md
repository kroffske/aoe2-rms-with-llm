# Label Conventions

## Required Labels

| Prefix | Purpose | Values |
|--------|---------|--------|
| `type:` | Work type | `task`, `bug`, `chore` |
| `prio:` | Priority | `P0`, `P1`, `P2`, `P3` |
| `area:` | Domain | project-specific |

## Usage

```bash
gh issue create --label "type:task" --label "prio:P2" --label "area:auth"
gh issue edit 123 --add-label "type:bug"
```
