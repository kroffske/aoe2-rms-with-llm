---
description: Resume work on active epic. Triggers on "продолжи работу", "resume work", "где я остановился", "what was I working on", "continue epic".
argument-hint: [epic-slug]
---

# Resume Work

> Quick context recovery for continuing work. Use when starting a new session.

**Epic**: `$ARGUMENTS` (optional)

---

## Step 0: Get Unified Task List

### 0.1 Call tasks.py

```bash
python3 .claude/skills/gh-toolkit/tasks.py --json
```

### 0.2 Parse JSON response

Extract from response:
- `tasks[]` — array of task objects
- `meta.github_available` — boolean
- `error` — null or error message

Each task object:
```json
{
  "id": "GH10",
  "title": "Feature ABC",
  "status": "in_progress",
  "priority": "P1",
  "source": "github",
  "issue_url": "https://github.com/.../issues/10",
  "epic_path": "tasks/GH10-feature-abc/",
  "next_task": "Implement user authentication"
}
```

### 0.3 Handle errors

If `error` is not null or script fails:
1. Show warning: "GitHub unavailable, using local tasks only"
2. Fall back to Step 1.2 (old behavior)

---

## Step 1: Find Active Work

### 1.1 If epic argument provided

Search for epic in tasks.py output by ID match:
1. Match by `id` field (e.g., "GH10", "LCL1", "2026-01-04-slug")
2. Use `epic_path` from matched task
3. If not found in worklist, search locally:
   ```
   tasks/{epic-slug}/epic.md
   tasks/YYYY-MM-DD-{epic-slug}/epic.md
   ```

### 1.2 If epic NOT provided

From worklist JSON:

1. Filter tasks by `status: "in_progress"`
2. If multiple in-progress, show selection list
3. If none in-progress, show all active tasks
4. Let user select which to resume

### 1.3 Fallback (if tasks.py failed)

Use old behavior:
1. Check TODO.md "Active Work" section:
   ```bash
   grep -A 10 "## Active Work" TODO.md
   ```
2. Select first epic with status "In Progress"
3. Open its artifacts/progress.md or epic.md

---

## Step 2: Load Context

### 2.1 Check progress.md (if exists)

Read `{epic_path}/artifacts/progress.md` and extract:
- **What's Done** — completed tasks
- **What's Next** — next task
- **Active Files** — files being worked on
- **Blockers** — any issues

### 2.2 If progress.md doesn't exist

Read `{epic_path}/epic.md` and find:
- Last completed task `[x]`
- First incomplete task `[ ]`
- Current Focus (if specified)

Use `next_task` from worklist JSON if available.

### 2.3 Load files

Read files from "Active Files" or files related to current task.

---

## Step 3: Report Status

### 3.1 If showing task selection

Display unified task list:

```
═══════════════════════════════════════════════════════════════
                        ACTIVE WORK
═══════════════════════════════════════════════════════════════

  #  Source   Status        Title
  ─────────────────────────────────────────────────────────────
  1  GitHub   in_progress   Feature ABC (#10)
  2  Local    pending       LCL-permissions-template
  3  Local    in_progress   2026-01-04-github-tasks

Select task (1-3) or press Enter for #1:
═══════════════════════════════════════════════════════════════
```

### 3.2 After task selected (or single task)

Display resume summary:

```
═══════════════════════════════════════════════════════════════
                  RESUME: {Epic Title}
═══════════════════════════════════════════════════════════════

GitHub:     {issue_url or "n/a (local only)"}
Epic:       {epic_path}epic.md
Status:     {status}
Next task:  {next_task}

Active files:
  - {file1}
  - {file2}

{Blockers if any}

Ready to continue? Use /task:implement {epic-slug}
═══════════════════════════════════════════════════════════════
```

---

## Step 4: Continue Work

Offer options:

1. **Continue current task**: `/task:implement {epic-slug}`
2. **Check plan**: Read `artifacts/plan.md`
3. **View full epic**: Read `epic.md`

---

## progress.md Format

If you need to create progress.md:

```markdown
# Progress: {Epic Name}

**Last Updated:** YYYY-MM-DD HH:MM
**Session:** N

## What's Done
- [x] Task 1 description
- [x] Task 2 description

## What's Next
- [ ] Task 3 description — brief note on approach

## Active Files
- `path/to/file1.py` — what's being changed
- `path/to/file2.py` — what's being changed

## Blockers
- None / or describe issues

## Notes
Any important context for next session.
```

---

## Rules

1. **Don't start work without context** — load progress first
2. **Update progress.md** — before ending session
3. **One epic at a time** — focus on current work
4. **Source awareness** — GitHub tasks may have remote updates
