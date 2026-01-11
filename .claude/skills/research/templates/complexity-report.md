# Template: Complexity Report

Use when documenting assessment phase.

---

## Complexity Report

**Question:** {original question}
**Score:** X/10
**Mode:** quick | standard | deep

### Dimensions

| Dimension | Score | Rationale |
|-----------|-------|-----------|
| Scope | X | Single module / Multiple / System-wide |
| Uncertainty | X | Known patterns / Some unknowns / Novel |
| Risk | X | Reversible / Moderate / High stakes |
| Dependencies | X | Isolated / Affects 2-3 / Wide-reaching |

### Agent Plan

| Agent | Role | Parallel/Sequential |
|-------|------|---------------------|
| scout-haiku | Codebase exploration | Parallel |
| architect | Design analysis | Parallel |
| expert | Feasibility | Sequential (after above) |

### Scope Lock

**IN scope:**
- What will be researched

**OUT of scope:**
- What will NOT be researched
- Explicitly excluded areas

### Confidence Target

{mode} mode requires {X}% confidence to conclude.
