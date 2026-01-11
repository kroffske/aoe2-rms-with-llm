# Create Epic (Task)

Start response with: `Создаю Эпик для таски: <Title>`.

## Constraints

- Do not explore the repo before creating the epic.
- Generate full epic content before running commands.
- If context is missing, use the minimal draft template; do not invent details.

## Inputs

- Title, Goal, Context, Tasks
- Labels: `type:*`, `prio:P*`, optional `area:*` (see labels.md)
- Default priority to `P2` when not specified

> **If label errors:** Run `/repo:gh-projects` to create standard labels.

## Title and slug

- Title in English for a readable slug.
- Optional scope prefix: `auth: Add JWT refresh`.
- Slug = kebab-case of the full title (including scope).

## GitHub-backed flow

1. Choose Title, Goal, Context, Tasks, Priority, Area.
2. Create GitHub Issue with labels (`type:task`, `prio:P*`, optional `area:*`) and short body (Goal summary).
3. Capture issue number from the issue URL.
4. Create folder `tasks/GH<N>-<slug>/`.
5. Write `epic.md` with full content (template below).
6. Sync issue body from epic.md (**mandatory**):
   `gh issue edit <N> --body-file tasks/GH<N>-<slug>/epic.md`
7. Report path and issue URL.

## Local-only flow

- Use prefix `LC<N>-<slug>`.
- Skip GitHub commands and sync.

## epic.md template

```markdown
# Epic: Title

**Status:** In Progress
**Created:** YYYY-MM-DD
**Priority:** P2
**GitHub Issue:** #<N>

---

## Goal
{goal}

## Context
{context}

## Tasks Overview

### Phase 1: Название фазы
- [ ] **Задача 1** — подробное описание

## Links
- `path/to/file` — optional

---

## Definition of Done
- [ ] Задача выполнена
- [ ] Tests pass
```

## Minimal draft when context missing

```markdown
## Context

Контекста нет. Требуется анализ перед реализацией.

## Tasks Overview

### Phase 1: Анализ
- [ ] **Провести анализ задачи** — определить scope и подход

### Phase 2: Реализация
- [ ] Задачи появятся после анализа
```
