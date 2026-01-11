# task/* Commands

Epic and task lifecycle management.

## Flow

```
/task:create --> /task:implement --> /task:resume --> /task:close
   (init)         (execute)          (continue)        (archive)
```

---

## /task:create

**Create new epic** with full structure.

```
/task:create "add user notifications"
      |
      v
    tasks/2026-01-03-user-notifications/
    ├── epic.md        # Tasks, acceptance criteria
    ├── WORKLOG.md     # Progress log
    └── artifacts/     # Agent outputs
```

**When to use:**
- New feature from scratch
- New investigation/spike
- Need structured approach with traceability

---

## /task:implement

**Execute specific task** from existing epic.

```
/task:implement
      |
      v
    Read epic.md
      |
      v
    Find next unchecked task
      |
      v
    Implement it
      |
      v
    Mark checkbox [x]
```

**When to use:**
- Epic already exists
- Working through task list
- Focused on single task

---

## /task:resume

**Restore context** for continuing work.

```
/task:resume
      |
      v
    Find active epic (or ask)
      |
      v
    Read epic.md, WORKLOG.md
      |
      v
    Show status:
    - Completed tasks
    - Current task
    - Next steps
```

**When to use:**
- Starting new session
- Returning to previous work
- Need context refresh

---

## /task:close

**Complete epic** and move to done/.

```
/task:close
     |
     v
   Validate completion:
   - All tasks checked
   - Tests passing
   - Artifacts archived
     |
     v
   Move tasks/ → done/
     |
     v
   Create git commit
```

**When to use:**
- All tasks complete
- Definition of done met
- Archiving work

---

## Epic Structure

```
tasks/
├── 2026-01-03-feature-name/    # Active
│   ├── epic.md
│   ├── WORKLOG.md
│   └── artifacts/              # Agent outputs
└── done/                       # Completed
    └── 2026-01-01-old-epic/
```
