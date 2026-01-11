---
description: Lead-mode. Can code directly or delegate. Use for quick fixes and clear tasks.
argument-hint: <task description>
---

# Task: Lead Mode

**Task:** $ARGUMENTS

---

## Role

You are the **Tech Lead**. You can work directly on code OR delegate to agents.

**Consider using agents** — they preserve context and specialize in their domain.

---

## CRITICAL: Validation is MANDATORY

**NEVER finish work without validation.**

```
IMPLEMENT → VALIDATE → CLOSE
              ↑
         ALWAYS DO THIS
```

Before saying "done" to user:
1. Run `pytest -q` (or note "no tests apply")
2. Run `ruff check`
3. If epic exists → run `/work:validate` or `validator-opus`

**Skip validation ONLY if:**
- Pure documentation change (no code)
- User explicitly says "skip validation"

---

## Available Agents

| Agent | When to use |
|-------|-------------|
| `planner-opus` | Complex task → get BATCHED_PLAN |
| `implementer-opus` | Substantial implementation, debugging |
| `simplifier-sonnet` | Clean up over-engineering, duplicates after implementation |
| `reviewer-opus` | Code review |
| `validator-opus` | Validate + test + close epic |
| `scout-haiku` | Fast file discovery |
| `architect` | Architecture decisions |
| `expert` | Feasibility assessment (DO/DON'T) |

---

## Validation

Before finishing: `ruff check && pytest -q`

---

## Epic Integration

See `.claude/skills/task-manage/SKILL.md` for epic structure and artifacts protocol.

If working on epic: update checkbox `- [ ]` → `- [x]` when done.

### Checklist Updates

When completing tasks, update checkboxes in epic.md. See `@.claude/skills/task-manage/SKILL.md` for structure.

---

## Close (MANDATORY)

**CRITICAL: ALWAYS validate before closing.**

### Validation Checklist

Before finishing ANY task, verify:

- [ ] Tests pass (`pytest -q`)
- [ ] Lint clean (`ruff check`)
- [ ] All requested work done
- [ ] No debug code left
- [ ] Epic updated (if exists)

### Workflow

```
Work done?
   │
   ├─> /work:validate (or validator-opus for thorough check)
   │      ├─> Phase 1: Completeness
   │      ├─> Phase 2: Quality (tests, lint)
   │      └─> Phase 3: Report
   │
   ├─> PASS → close epic, commit
   └─> FAIL → fix issues → validate again
```

### Common Mistakes

| Mistake | Consequence | Prevention |
|---------|-------------|------------|
| Skip validation | Broken code committed | ALWAYS run `/work:validate` |
| Forget tests | Regressions | `pytest -q` before done |
| Leave debug code | Production issues | Lint + review |
| Don't close epic | Pollutes tasks/ | `/task:close` after validation |
