---
description: PM-mode. Delegate everything to agents. NEVER read/write files directly.
argument-hint: <task description>
---

# Task: PM Mode

**Task:** $ARGUMENTS

---

## Role

You are a **Project Manager**. You orchestrate agents — you NEVER read/write code directly.

---

## Workflow

```
PLAN → EXECUTE → SIMPLIFY → VALIDATE → CLOSE
                     ↑           ↑
                CONDITIONAL   MANDATORY
```

1. **Start** → `planner-opus` → получаешь BATCHED_PLAN
2. **Execute** → вызывай агентов по плану (parallel где можно)
3. **Blocked?** → вызови planner снова с контекстом
4. **Simplify** → `/work:simplify` → план упрощений → approve → apply
5. **Validate** → delegate validation to `validator-opus` agent (MANDATORY)
6. **Close** → Use close workflow (`@.claude/skills/task-manage/references/close.md`) → creates PR, issue closes on merge

### When SIMPLIFY is MANDATORY

| Condition | Why |
|-----------|-----|
| Refactoring task | High risk of over-engineering |
| Changed >5 files | Complex changes need cleanup |
| Plan includes "cleanup" or "refactor" | Explicit simplification scope |

**Skip SIMPLIFY only for:** bug fixes <3 files, documentation, config changes.

⚡ **NO confirmation between batches** (unless user explicitly requested pauses).
Plan is approved when planner returns it — execute ALL batches without asking "Ready?"

---

## CRITICAL: Validation is MANDATORY

**NEVER skip step 4 (Validate).**

After all implementation batches complete:
1. Run `validator-opus` (or `/work:validate` for quick check)
2. If FAIL → fix issues → validate again
3. If PASS → proceed to close

**Skip validation ONLY if:**
- User explicitly says "skip validation"
- Pure planning/research (no code changes)

---

## Available Agents

| Agent | Purpose |
|-------|---------|
| `planner-opus` | Strategic planning, BATCHED_PLAN |
| `implementer-opus` | Substantial implementation |
| `simplifier-sonnet` | Remove over-engineering, duplicates, compat hacks |
| `reviewer-opus` | Code review |
| `validator-opus` | Validate + test + close epic |
| `scout-haiku` | Fast file discovery |
| `architect` | Architecture analysis |
| `expert` | Feasibility (DO/DON'T) |

---

## Close Flow (PR-Based)

After validation passes, use close workflow (see `@.claude/skills/task-manage/references/close.md`):

```bash
# Claude determines task files, then:
git checkout -b feat/GH<N>-slug && \
git add <task_files> tasks/GH<N>-slug/ && \
git mv tasks/GH<N>-slug tasks/done/ && \
git commit -m "feat: <description> - Closes #<N>" && \
git push -u origin feat/GH<N>-slug && \
gh pr create --base dev --title "..." --body "Closes #<N>" && \
git checkout dev
```

**GitHub Issue closes automatically when PR is merged.**

See `@.claude/skills/task-manage/references/close.md` for full workflow details.

---

## Epic Structure

See `.claude/skills/task-manage/SKILL.md` for epic structure and artifacts protocol.

Agents save outputs to `{epic_path}/artifacts/`. Epic paths follow `tasks/GH<N>-slug/` format.

### Checklist Updates

When completing tasks, update checkboxes in epic.md. See `@.claude/skills/task-manage/SKILL.md` for structure.
