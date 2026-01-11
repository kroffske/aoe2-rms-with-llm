---
description: |
  Validate completed work before closing. Use: /work:validate, /work:validate 22, /work:validate GH22, /work:validate tasks/GH22-slug/. Runs tests, lint, checks completeness. Returns ACCEPTED (ready to close) or FINDINGS (needs rework). Use after implementation.
argument-hint: [epic-path]
---

# /work:validate — Validate Work

**Epic:** $ARGUMENTS

Apply validation skill (`@.claude/skills/validation/SKILL.md`) for structured validation with two outcomes.

---

## Two Outcomes

```
/work:validate [epic-path]
    │
    ├── ACCEPTED ✅
    │   └── All checks pass
    │   └── Ready to close epic
    │   └── Next: /task:close
    │
    └── FINDINGS ⚠️
        └── Issues found
        └── Needs rework
        └── Next: Fix → Validate again
```

---

## Process

Apply validation workflow (`@.claude/skills/validation/SKILL.md`):

```
Phase 1: CONTEXT
    └── Read epic.md, understand scope

Phase 2: TESTS
    └── pytest -q --tb=short

Phase 3: LINT
    └── ruff check .

Phase 4: COMPLETENESS
    └── All tasks in epic.md done?

Phase 5: VERDICT
    └── ACCEPTED or FINDINGS
```

---

## Quick Mode

For small changes, minimal validation:

```bash
pytest -q && ruff check
```

Skip completeness check if:
- Single file change
- Typo fix
- Documentation only

---

## Workflow Integration

```
/work:lead "implement X"
    └─> (work done)
        └─> /work:validate
            ├─> ACCEPTED → /task:close
            └─> FINDINGS → fix → /work:validate
```

---

## References

- `@.claude/skills/validation/SKILL.md` — Full validation skill
- `.claude/agents/validator-opus.md` — Deep validation with ultrathink
