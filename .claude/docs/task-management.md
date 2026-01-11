# Task Management System

The task management system organizes work as **epics** — self-contained folders that group related tasks, track progress, and sync with GitHub Issues for visibility.

---

## Overview

**What is an Epic?**

An epic is a folder in `tasks/` containing:
- `epic.md` — task overview and metadata
- `WORKLOG.md` — append-only work history (optional)
- `artifacts/` — agent outputs, plans, reviews (optional)

**Why use epics?**

- Single point of truth for feature work
- Automatic GitHub Issue synchronization (no manual copy-paste)
- Work continuity across sessions (progress.md, WORKLOG.md)
- Clear definition of done (all tasks checked ✅)

**Naming convention:**

| Type | Prefix | Example | Use Case |
|------|--------|---------|----------|
| GitHub-backed | `GH<#>` | `tasks/GH9-workflow/` | Default, team visible, creates Issue #9 |
| Local-only | `LC<#>` | `tasks/LC1-spike/` | Offline work, experiments, no GitHub |
| Legacy | `YYYY-MM-DD` | `tasks/2026-01-03-old/` | Old format, use migrate to convert |

---

## Quick Start

### Create Epic (GitHub-backed)

```bash
/task:create "Feature Name"
```

Prompts for:
- **Goal** — one sentence outcome
- **Context** — why this is needed
- **Tasks** — concrete action items

Creates:
- GitHub Issue #N
- `tasks/GH<N>-<slug>/` folder
- `epic.md` with full content synced to Issue

### Work on Task

```bash
/task:resume                          # Find active work
/task:implement tasks/GH9-workflow/   # Start next task
```

Reads epic, marks task in-progress, implements change, validates, commits.

### Finish Work

```bash
/task:close tasks/GH9-workflow/
```

Validates all tasks done, runs tests, closes GitHub Issue, moves to `done/`.

---

## Commands Reference

### /task:create — Create New Epic

```bash
/task:create "Feature name"              # GitHub-backed (default)
/task:create "Quick spike" --local       # Local-only (no GitHub)
```

**What it does:**
1. Creates GitHub Issue (unless `--local`)
2. Creates `tasks/GH<N>-<slug>/` folder
3. Writes `epic.md` with content
4. Syncs Issue body with epic.md
5. Adds to project board (if configured)
6. Commits and pushes

**Output:**
```
Created epic: tasks/GH15-feature-name/
GitHub Issue: #15 (https://github.com/owner/repo/issues/15)
```

**When:** Starting new feature or spike

---

### /task:implement — Implement Single Task

```bash
/task:implement tasks/GH9-workflow/      # Implement next incomplete task
/task:implement tasks/GH9-workflow/ 2    # Implement specific task #2
```

**What it does:**
1. Loads epic.md, finds task (first incomplete or by ID)
2. Reads affected files
3. Implements changes (follows project rules)
4. Runs tests and lint
5. Commits with conventional message
6. Marks task `[x]` in epic.md
7. Suggests next task

**Key rule:** One task at a time, atomic commits.

**When:** Working through epic tasks sequentially

---

### /task:resume — Resume Work Session

```bash
/task:resume                             # Show active epics, pick one
/task:resume tasks/GH9-workflow/         # Jump to specific epic
```

**What it does:**
1. Lists all in-progress epics from GitHub + local
2. Shows which tasks remain
3. Loads progress.md (if exists) with context
4. Suggests next task

**Output:**
```
RESUME: Feature ABC
GitHub:     #10
Epic:       tasks/GH10-feature-abc/epic.md
Status:     in_progress
Next task:  Implement user authentication

Active files:
  - lib/auth/login.py
  - tests/auth/test_login.py
```

**When:** Starting new work session

---

### /task:close — Finalize Epic

```bash
/task:close tasks/GH9-workflow/
```

**What it does:**
1. Validates all tasks `[x]`
2. Runs tests and lint
3. Closes GitHub Issue
4. Moves epic to `tasks/done/`
5. Creates closure commit

**Pre-close checklist:**
- [ ] All tasks in epic.md marked `[x]`
- [ ] Tests pass
- [ ] Code reviewed
- [ ] Documentation updated

**When:** All tasks complete, ready to finalize

---

## Epic Structure

### Folder Layout

```
tasks/
├── GH9-feature/
│   ├── epic.md              # Required: tasks overview + metadata
│   ├── WORKLOG.md           # Optional: append-only work history
│   ├── artifacts/           # Optional: agent outputs
│   │   ├── plan.md          # Planning output
│   │   ├── review.md        # Code review findings
│   │   └── implementation.md
│   └── findings/            # Investigation notes
├── LC1-spike/               # Local-only (no GitHub)
└── done/
    └── GH5-completed/       # Closed epics moved here
```

### epic.md Format

```markdown
# Epic: Feature Title

**Status:** In Progress | Done | Backlog
**Created:** 2026-01-05
**Priority:** P1 | P2 | P3
**GitHub Issue:** #9 (optional, added by /task:create)

## Goal

One sentence describing the outcome.

## Context

Why this is needed (optional).

## Tasks Overview

### Phase 1: Core
- [ ] Concrete task 1
- [ ] Concrete task 2
- [x] Completed task

### Phase 2: Polish
- [ ] Additional tasks

## Definition of Done
- [ ] All tasks completed
- [ ] Tests passing
- [ ] Documentation updated
```

**Key rules:**
- Use checkboxes `[ ]` for tasks (auto-updated by /task:implement)
- Group tasks by phase (logical flow)
- Clear action items (not vague goals)

### progress.md Format (Optional)

Session tracking file for resuming work:

```markdown
# Progress: Epic Name

**Last Updated:** 2026-01-05 14:30
**Session:** 2

## What's Done
- [x] Task 1 description
- [x] Task 2 description

## What's Next
- [ ] Task 3 — brief note on approach

## Active Files
- `lib/auth/login.py` — implementing login form
- `tests/auth/test_login.py` — adding tests

## Blockers
None

## Notes
Configuration set in .env, no other dependencies.
```

Created automatically by `/task:resume` if needed.

---

## Workflow Diagrams

### Simple Workflow: Create → Implement → Close

```
User: create "Add login"
        │
        ▼
    /task:create
        │
        ├─ Create GitHub Issue #15
        ├─ Create tasks/GH15-add-login/
        ├─ Write epic.md
        └─ Push to remote
        │
        ▼
    User: /task:implement
        │
        ├─ Read epic.md
        ├─ Find first [ ] task
        ├─ Edit files
        ├─ Run tests
        ├─ Commit
        └─ Mark [x] in epic.md
        │
        ▼
    Next task? (repeat or close)
        │
        ▼
    /task:close
        │
        ├─ Validate all [x]
        ├─ Close GitHub Issue
        ├─ Move to done/
        └─ Done!
```


### Resume Workflow

```
/task:resume
        │
        ├─ Check tasks.py
        │  (lists all active epics)
        │
    ┌───┴─────────────────────────────┐
    │                                 │
Multiple epics            Single epic or user selects
    │                                 │
Show selection        Load epic.md
    │                      │
    └──┬───────────────────┘
       │
    Load progress.md (if exists)
       │
    Show context:
    ├─ Last done task
    ├─ Next task
    ├─ Active files
    └─ Blockers
       │
    Offer: /task:implement to continue
```

---

## GitHub Integration

### Issue Synchronization

**How it works:**

1. `/task:create` creates GitHub Issue with epic.md content
2. Issue #N → epic folder name: `tasks/GH<N>-<slug>/`
3. `/task:close` closes Issue + moves epic to done/

### Project Board Integration

If `.gh-project` file exists with GitHub project number:
- `/task:create` adds new issue to board
- `/task:close` moves issue to "Done" column

**Config file (.gh-project):**
```
owner=myorg
project=1
```

### Auto-Close on Merge

Feature workflow creates PR with `Fixes #<N>` reference:
```
Fixes #23

🤖 Generated with Claude Code
```

When PR is merged → Issue #23 auto-closes.

---

## Tips & Patterns

### Best Practices

**1. Clear task descriptions:**
```markdown
# Good
- [ ] Implement UserAuth class with login() method

# Bad
- [ ] Do user stuff
- [ ] Security things
```

**2. Atomic commits per task:**
Each `/task:implement` = one commit. Makes history readable.

**3. Use phases for grouping:**
```markdown
### Phase 1: Core functionality
- [ ] Task 1
- [ ] Task 2

### Phase 2: Tests & docs
- [ ] Task 3
```

**4. Document blockers:**
```markdown
## Blockers
- Waiting for API design review (see GH#15)
- Need access to staging database
```

### Common Patterns

**When to use each command:**

| Situation | Command |
|-----------|---------|
| Starting new feature | `/task:create` |
| Feature already created, do one task | `/task:implement` |
| Between sessions, find active work | `/task:resume` |
| Feature complete, ready to ship | `/task:close` |

### Gotchas

**1. Don't manually edit GitHub Issue**

The epic.md is source of truth.

**2. Keep epic.md in sync with actual tasks**

Mark tasks `[x]` as you complete them (done by `/task:implement`). `/task:close` validates all are marked.

**3. Use local epics for exploration**

```bash
/task:create "Spike experiment" --local   # No GitHub Issue
```

**4. Preserve artifacts**

Save meaningful outputs to `artifacts/`:
- `plan.md` — design decisions
- `review.md` — code review findings
- `implementation-notes.md` — technical details

**5. Session continuity**

Before ending session, update `progress.md`:
```bash
# Progress: Current Epic
**Last Updated:** 2026-01-05 16:00
## What's Done
- [x] Task 1
## What's Next
- [ ] Task 2 — need to refactor auth
## Blockers
- Database schema pending review
```

---

## WORKLOG.md Format

Append-only history of work done on epic (follows handoff protocol).

```markdown
## 2026-01-05

### implementer-opus: Implementation
Implemented UserAuth class with login() and logout() methods.
- Status: DONE
- Files: lib/auth/auth.py, tests/auth/test_auth.py
- Artifacts: [implementation.md](./artifacts/implementation.md)

### reviewer-opus: Code Review
Reviewed auth.py, noted 2 style issues, 1 potential security concern.
- Status: DONE (changes requested)
- Files: lib/auth/auth.py
- Artifacts: [review.md](./artifacts/review.md)
```

Each entry includes:
- Date
- Agent name (or person)
- Work type (Planning, Implementation, Review, etc.)
- 1-2 sentence summary
- Status: DONE | PARTIAL | BLOCKED
- Files modified
- Artifact links

---

## Troubleshooting

### Epic folder exists but no GitHub Issue

Use `/task:create` to create a new GitHub-backed epic, or manually create a GitHub Issue and link it in epic.md.

### GitHub Issue exists but folder missing

```bash
# Manual recovery:
mkdir -p tasks/GH9-slug/
cp epic-content-from-issue > tasks/GH9-slug/epic.md
git add tasks/GH9-slug/
git commit -m "refactor: recover GH9 epic folder"
```

### Can't find active epic in /task:resume

```bash
# Force refresh GitHub task list:
python3 .claude/skills/gh-toolkit/tasks.py --json

# Manual search:
grep -r "in_progress\|In Progress" tasks/*/epic.md
```

### Task marked [x] but epic.md not updated

Manually edit epic.md and mark the task `[x]`. The issue will be synchronized on next `/task:close`.

---

## See Also

- **task-manage skill** — epic structure reference (STRUCTURE)
- **handoff skill** — artifact protocol, WORKLOG.md format (AGENTS)
- **task-manage close reference** — detailed closure workflow
