# Task Lifecycle

From idea to completion.

## Overview

```
    +------------------+
    |  /task:create    |  <-- Create epic
    +--------+---------+
             |
             v
    +------------------+
    |  tasks/YYYY-.../  |
    |  - epic.md       |
    |  - WORKLOG.md    |
    +--------+---------+
             |
             v
    +------------------+
    |  Choose mode:    |
    |  /work:lead      |  <-- Direct work
    |  /work:team      |  <-- Delegate
    +--------+---------+
             |
             v
    +------------------+
    |  Implementation  |
    |  - Code changes  |
    |  - Update epic   |
    |  /release:commit |
    +--------+---------+
             |
             v
    +------------------+
    |   /task:close    |  <-- Finalize
    |  - Validate      |
    |  - Move to done/ |
    |  - Close GH issue|
    +------------------+
```

## Commands by Phase

| Phase | Command | Purpose |
|-------|---------|---------|
| Create | `/task:create` | Create epic |
| Work | `/work:lead` | Direct implementation |
| Work | `/work:team` | Agent delegation |
| Work | `/release:commit` | Save progress |
| Close | `/task:close` | Archive and sync |

## Next Session

```
    /task:resume
         |
         v
    (from local or GitHub)
```

## Detailed Phase Flow

### Phase 1: Create Epic

**Create GitHub-backed epic:**
```
User: "I need feature X"
         |
         v
    /task:create "feature X"
         |
         v
    Creates:
    tasks/GH10-feature-x/
    ├── epic.md       # Acceptance criteria, tasks
    └── WORKLOG.md    # Empty, ready for entries
    AND creates GitHub Issue #10
```

**Local-only (experiments):**
```
    /task:create "quick spike" --local
         |
         v
    Creates:
    tasks/LC1-quick-spike/
    (no GitHub Issue)
```

### Phase 2: Implementation

```
    /task:implement   or   /work:lead
         |
         v
    Work on tasks:
    [x] Task 1 - done
    [x] Task 2 - done
    [ ] Task 3 - in progress
    [ ] Task 4 - todo
         |
         v
    After each logical chunk:
    /release:commit
         |
         v
    Update WORKLOG.md
```

### Phase 3: Completion

```
    All tasks done?
         |
         v
    /task:close
         |
         +---> Validate (pytest, ruff)
         +---> Update epic.md status
         +---> Move to tasks/done/
         +---> Close GitHub issue (#XX)
         +---> Commit
         |
         v
    Epic archived!
```

## File Structure

```
tasks/
├── GH9-active-epic/            # GitHub Issue #9 (recommended)
│   ├── epic.md
│   ├── WORKLOG.md
│   └── artifacts/
│       ├── plan.md             # From planning agents
│       └── review.md           # From review agents
│
├── LCL1-experiment/            # Local-only (no GitHub)
│
├── 2026-01-03-legacy/          # Old format (still works)
│
└── done/                       # Completed epics
    ├── GH5-old-epic/
    └── GH8-another/
```

