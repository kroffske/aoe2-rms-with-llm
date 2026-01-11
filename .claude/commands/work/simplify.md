---
description: Analyze code and propose simplifications. Returns plan for review before applying.
argument-hint: [<files> | --recent | --staged]
---

# /work:simplify — Simplification Planning

> Анализирует код и предлагает упрощения. **Не применяет изменения** — только план.

## Input Modes

| Mode | Argument | What to analyze |
|------|----------|-----------------|
| Files | `src/api.py src/utils.py` | Указанные файлы |
| Recent | `--recent` | `git diff HEAD~1 --name-only` |
| Staged | `--staged` | `git diff --cached --name-only` |
| Default | (none) | All uncommitted changes |

---

## Process

### Phase 1: Gather Context

```bash
# Determine files to analyze
git status --porcelain          # default
git diff HEAD~1 --name-only     # --recent
git diff --cached --name-only   # --staged
```

**Read AGENTS.md** for project rules (golden_rules, constraints).

### Phase 2: Analyze (simplifier-sonnet)

Spawn `simplifier-sonnet` in **analysis-only mode**:

```
Analyze these files for simplification opportunities.
DO NOT make changes. Return a structured plan.

Focus on:
1. AGENTS.md violations
2. Backward compatibility hacks (re-exports, _unused vars, "removed" comments)
3. Over-engineering (ABCs with 1 impl, factories for 1 type)
4. Duplicate code
5. One-use helpers that can be inlined

For each finding, provide:
- File and line
- Current code (snippet)
- Proposed change
- Risk level (safe/moderate/review-needed)
```

### Phase 3: Output Plan

Return structured plan for user review:

```markdown
## Simplification Plan

**Scope:** {N} files analyzed
**Date:** YYYY-MM-DD

### Summary

| Category | Count | Risk |
|----------|-------|------|
| AGENTS.md violations | N | moderate |
| Backward compat hacks | N | safe |
| Over-engineering | N | review-needed |
| Duplicates | N | safe |
| Inline opportunities | N | safe |

---

### Proposed Changes

#### 1. [SAFE] Remove backward compat re-export

**File:** `src/models.py:15`
**Current:**
```python
OldModel = NewModel  # backward compat
```
**Proposed:** Delete line
**Reason:** No external callers found

---

#### 2. [MODERATE] Inline one-use helper

**File:** `src/api.py:42`
**Current:**
```python
def _format_response(data):
    return {"status": "ok", "data": data}

# called only once at line 87
```
**Proposed:** Inline at call site, delete function
**Reason:** Single use, trivial logic

---

#### 3. [REVIEW-NEEDED] Flatten inheritance

**File:** `src/processors.py:10-45`
**Current:**
```python
class BaseProcessor(ABC):
    @abstractmethod
    def process(self): ...

class ConcreteProcessor(BaseProcessor):
    def process(self): ...
```
**Proposed:** Remove ABC, use concrete class directly
**Reason:** Only one implementation exists
**Risk:** Check for isinstance() usage first

---

### Verification Commands

```bash
# After applying changes
pytest -q
ruff check .
```

---

## Decision

- [ ] **Apply all SAFE** — низкий риск
- [ ] **Apply SAFE + MODERATE** — средний риск, рекомендуется
- [ ] **Apply all** — включая REVIEW-NEEDED
- [ ] **Cherry-pick** — выбрать конкретные изменения
- [ ] **Skip** — не применять
```

---

## After Approval

When user approves (fully or partially):

1. Apply selected changes using Edit tool
2. Run verification (`pytest -q && ruff check .`)
3. Report results

```markdown
## Simplification Applied

**Changes:** {N} of {M} applied
**Status:** ✅ Tests pass | ❌ Tests fail

### Applied
- [x] Remove backward compat re-export (src/models.py)
- [x] Inline one-use helper (src/api.py)

### Skipped
- [ ] Flatten inheritance (user chose to skip)

### Verification
- pytest: ✅ 42 passed
- ruff: ✅ clean
```

---

## Risk Levels

| Level | Meaning | Auto-apply? |
|-------|---------|-------------|
| SAFE | No behavior change possible | Yes with `--apply-safe` |
| MODERATE | Behavior preserved if done correctly | After review |
| REVIEW-NEEDED | May affect external code | Manual review required |

---

## Flags

| Flag | Effect |
|------|--------|
| `--recent` | Analyze files from last commit |
| `--staged` | Analyze staged files only |
| `--apply-safe` | Auto-apply SAFE changes without asking |
| `--dry-run` | Only show plan, never apply (default) |

---

## Integration

Called automatically by `/work:team` when:
- Task is refactoring
- Changed >5 files
- Plan includes "cleanup" or "refactor"

Can also be called manually anytime.
