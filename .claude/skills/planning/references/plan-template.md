# Plan Template

Use this structure for `artifacts/plan.md`.

```markdown
# Plan: <Title>

**Date:** YYYY-MM-DD
**Epic:** tasks/<epic>/
**Workflow:** standard | deep | research

## Scope Lock
- Goal:
- In scope:
- Out of scope:
- Constraints:
- Assumptions:

## Decisions (Locked)
1. <decision> — <rationale>
2. <decision> — <rationale>

## System Overview (if needed)
- Components, data flow, integration points.

## Agent Orchestration
- Sequencing: <batch order and handoff points>
- Ownership: <batch-level owner or task-level split>
- Parallelism: <what can run in parallel and why>
- Simplification gate: <MANDATORY if refactoring OR >5 files; otherwise optional>
- Review/validation gates: <when reviewer/validator engage>

## File-Level Changes

### Create
| Path | Purpose | Notes |
|------|---------|-------|
| ...  | ...     | ...   |

### Update
| Path | Change | Notes |
|------|--------|-------|
| ...  | ...    | ...   |

### Delete
| Path | Reason | Migration/Replacement |
|------|--------|-----------------------|
| ...  | ...    | ...                   |

## Batches

### Batch 0 (optional, parallel)
**Execution Mode:** single-agent | split-by-task
**Owner/Assignees:** <agent(s)>
**Parallelizable:** <steps or “none”>
| Agent | Task | Output |
|-------|------|--------|
| ...   | ...  | ...    |

### Batch 1
**Execution Mode:** single-agent | split-by-task
**Owner/Assignees:** <agent(s)>
**Parallelizable:** <steps or “none”>
| Step | Agent | Files | What | How | Tests |
|------|-------|-------|------|-----|-------|
| 1.1  | ...   | ...   | ...  | ... | ...   |

### Batch 2
**Execution Mode:** single-agent | split-by-task
**Owner/Assignees:** <agent(s)>
**Parallelizable:** <steps or “none”>
| Step | Agent | Files | What | How | Tests |
|------|-------|-------|------|-----|-------|
| 2.1  | ...   | ...   | ...  | ... | ...   |

## Testing & Validation
- Tests to add/modify:
  - ...
- Commands:
  - ...

## Migration / Cutover (if applicable)
- Steps:
  - ...
- Rollback plan:
  - ...

## Risks & Mitigations
- Risk: ... → Mitigation: ...

## Open Questions (must be resolved before execution)
- ...

## Acceptance Criteria
- ...
```
