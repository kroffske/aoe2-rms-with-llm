---
name: task-manage
description: Task/epic lifecycle — create, sync, cleanup, close, prioritize. Use for tasks/ and GitHub Issues. Triggers: task, epic, таск, приоритет, priority.
---

# task-manage

Workflow guidance for task and epic lifecycle.

## Use when

User asks to create, delete, resume, or close tasks/epics.

**Examples:**
- User: "создай таск для авторизации" → `/task-manage`
- User: "заведи эпик onboarding" → `/task-manage`
- User: "удали тестовые таски" → `/task-manage`
- User: "close epic", "resume work" → `/task-manage`
- User: "создай priority matrix" → `/task-manage`

## This skill covers:
- Creating new tasks/epics
- Cleaning up or deleting tasks/epics
- Priority matrix (`tasks/priority.md`)
- Syncing GitHub Issues with local epics
- PR creation and merge flow

## Naming Convention

| Type | Prefix | Example |
|------|--------|---------|
| GitHub-backed | `GH<#>-` | `tasks/GH9-workflow/` |
| Local-only | `LC<#>-` | `tasks/LC1-spike/` |
| Legacy | `YYYY-MM-DD-` | `tasks/2026-01-03-old/` |

## Epic Structure

```
tasks/GH<N>-slug/
├── epic.md
├── WORKLOG.md
└── artifacts/
```

## epic.md Format

```markdown
# Epic: Title

**Status:** In Progress
**Created:** 2026-01-05
**Priority:** P2
**GitHub Issue:** #9

---

## Goal
Чего хотим достичь — одно предложение с измеримым результатом.

## Context
Проблема и контекст подробно:
- Текущее состояние (что есть)
- Проблема (что не устраивает)
- Влияние (почему важно)

## Tasks Overview

### Phase 1: Название фазы
- [ ] **Задача** — подробное описание, файлы, классы
- [x] **Готово** — что было сделано

## Links
- `path/to/file.py` — связанные файлы
- `artifacts/plan.md` — детальный план

---

## Definition of Done
- [ ] Критерий завершения
- [ ] Tests pass
```

## Sections

- [@sections/create.md] - Create epic/task workflow
- [@sections/cleanup.md] - Delete/cleanup task folders
- [@sections/intake.md] - Confirm step and scope lock
- [@sections/labels.md] - Label conventions
- [@sections/sync-rules.md] - GitHub <-> local sync
- [@sections/pr-flow.md] - PR/merge patterns
- [@sections/priority.md] - Priority matrix template

## References

- [@references/close.md] - Close/commit workflow (epic + research)

## Integration

- Links to `understand` skill for complex intake
