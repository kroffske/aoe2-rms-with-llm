# GitHub <-> Local Sync

## Epic Location

Local epic: `tasks/GH<N>-slug/epic.md`

## Sync Commands

```bash
# Create issue, then sync body from epic
gh issue create --title "..." --body "Goal summary" --label "type:task" --label "prio:P2"
gh issue edit <N> --body-file tasks/GH<N>-slug/epic.md

# Update issue status
gh issue edit <N> --add-label "status:in-progress"

# Close via PR
gh pr create --title "feat: ... - Closes #<N>"
```

## WORKLOG.md

Append work progress to `tasks/GH<N>-slug/WORKLOG.md`:
- Status changes
- Blockers
- Key decisions
