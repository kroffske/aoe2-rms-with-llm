# gh/* Commands

GitHub integration - sync local tasks with Issues/Projects.

## Source of Truth

```
tasks/*.md files = PRIMARY (local)
GitHub Issues    = MIRROR (for visualization)
```

## Epic Commands

All epic operations use `/task:*` commands:

| Command | Purpose |
|---------|---------|
| `/task:create "Epic name"` | Create epic + GitHub Issue |
| `/task:close <path>` | Close Issue + move to done/ |

## Flow

```
/task:create --> work --> /task:close
    (init)                  (archive)
```

---

## /gh:projects

**Initialize GitHub** as task tracker.

```
/gh:projects
    |
    v
  Create labels:
  - epic, task, blocked, wip
    |
    v
  Create issue templates
    |
    v
  Create GitHub Project board
```

**When to use:**
- Setting up new project
- Want GitHub-based tracking
- One-time setup

---

## Common Scenarios

### New Feature (GitHub-backed)
```bash
/task:create "Add auth feature"
# → tasks/GH10-add-auth-feature/ + Issue #10
# Work on it...
# When done: /task:close
```

---

## Linking Convention

In `epic.md`:
```markdown
**GitHub Issue:** #123
```

Added by `/task:create` and `/task:close`. Use gh-toolkit skill for advanced GitHub operations.
