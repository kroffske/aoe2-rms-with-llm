---
description: Close epic, validate completion, close GitHub Issue. Triggers on "закрой эпик", "завершить таск", "close epic", "finish task", "done with epic".
argument-hint: <epic-ref>
---

# /task:close — Close Epic

Finalize epic: validate → close GitHub Issue via PR.

**Arguments:** `$ARGUMENTS`

---

## Process

```
/task:close <epic-ref>
    │
    ├── Step 1: VALIDATE (via @.claude/skills/validation/SKILL.md)
    │   ├── ACCEPTED → proceed
    │   └── FINDINGS → STOP, show issues
    │
    └── Step 2: CLOSE (if ACCEPTED)
        └── Apply @.claude/skills/task-manage/references/close.md workflow
```

### Step 1: Pre-Close Validation

Apply validation skill (`@.claude/skills/validation/SKILL.md`) before closing:

- [ ] All tasks in `epic.md` are `[x]`
- [ ] Tests pass (`pytest -q`)
- [ ] Lint clean (`ruff check`)

**If FINDINGS returned:** Stop and show issues. Fix first, then re-run `/task:close`.

### Step 2: Close Epic

Apply close workflow (see `@.claude/skills/task-manage/references/close.md`) — uses standard git/gh commands:

```bash
# Claude determines task files, then:
git checkout -b feat/GH<N>-<slug>
git add <task_files> tasks/GH<N>-<slug>/
git mv tasks/GH<N>-<slug> tasks/done/
git commit -m "feat: <description> - Closes #<N>"
git push -u origin feat/GH<N>-<slug>
gh pr create --base <default-branch> --title "..." --body "Closes #<N>"
git checkout <default-branch>
```

**NOTE:** Check default branch before PR creation:
```bash
gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name'
# Returns: main or dev
```

**Issue closes when PR is merged.**

---

## Quick Examples

```bash
# By issue number
/task:close 22

# By GH prefix
/task:close GH22

# Full path
/task:close tasks/GH22-feature-name/
```

### Argument Formats

| Format | Example | Resolves To |
|--------|---------|-------------|
| Issue number | `22` | `tasks/GH22-*/` |
| GH prefix | `GH22` | `tasks/GH22-*/` |
| Local epic | `LC1` | `tasks/LC1-*/` |
| Full path | `tasks/GH22-slug/` | as-is |

---

## References

- `@.claude/skills/validation/SKILL.md` — Validation workflow
- `@.claude/skills/task-manage/references/close.md` — Full close workflow with git/gh commands
