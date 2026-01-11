# Artifact Template

Standard structure for all handoff artifacts.

## Template

```markdown
# {Artifact Title}

**Agent:** {agent-type}
**Epic:** {epic-path}
**Created:** {YYYY-MM-DD HH:MM}

## Summary

2-3 sentences: what this artifact contains and key findings.

## Details

Full detailed content of the work performed.

### Section 1
...

### Section 2
...

## Decisions Made

| Decision | Rationale |
|----------|-----------|
| Choice A over B | Reason for choosing A |

## Open Questions

- [ ] Question needing resolution
- [ ] Another question

## Files Changed (if implementation)

| File | Change |
|------|--------|
| `path/to/file.py` | Added X functionality |

## Next Steps

1. Immediate next action
2. Follow-up action
```

## Examples by Agent Type

### planner-opus: plan.md

```markdown
# Implementation Plan: Feature X

**Agent:** planner-opus
**Epic:** tasks/2025-01-15-feature-x/
**Created:** 2025-01-15 10:30

## Summary

Plan for implementing Feature X in 3 phases over ~4 hours.

## Phase 1: Setup (30 min)
- Create new module structure
- Add config entries

## Phase 2: Core Implementation (2 hours)
...

## Decisions Made

| Decision | Rationale |
|----------|-----------|
| Use existing Provider pattern | Consistency with codebase |

## Open Questions

- [ ] Should we add caching?
```

### reviewer-opus: review.md

```markdown
# Code Review: PR #123

**Agent:** reviewer-opus
**Epic:** tasks/2025-01-15-feature-x/
**Created:** 2025-01-15 14:00

## Summary

Review of implementation.md changes. 2 critical issues, 3 suggestions.

## Critical Issues

1. **SQL Injection** in `query.py:45` - user input not sanitized
2. **Missing error handling** in `api.py:120`

## Suggestions

1. Consider extracting helper function for repeated logic
...

## Verdict

**CHANGES REQUIRED** - fix critical issues before merge.
```

### implementer-*: implementation.md

```markdown
# Implementation: Feature X

**Agent:** implementer-opus
**Epic:** tasks/2025-01-15-feature-x/
**Created:** 2025-01-15 12:00

## Summary

Implemented core Feature X functionality. 5 files changed, 2 new files.

## Changes

### New Files
- `locusrag/feature_x/core.py` - Main implementation
- `tests/unit/test_feature_x.py` - Unit tests

### Modified Files
- `locusrag/config/models.py` - Added FeatureXConfig
...

## Decisions Made

| Decision | Rationale |
|----------|-----------|
| Pydantic over dataclass | Project standard |

## Test Results

```
pytest tests/unit/test_feature_x.py -v
5 passed in 0.3s
```
```
