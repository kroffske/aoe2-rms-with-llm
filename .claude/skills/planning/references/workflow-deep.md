# Workflow: Deep Planning

Use for refactors, migrations, cross-cutting changes, or high-risk work.

## Steps

1. **Clarify + lock scope**
   - Confirm constraints, migration expectations, and out-of-scope items.
2. **Recon (scout-haiku)**
   - Build a file map and find existing patterns.
3. **Multi-perspective input (parallel)**
   - Architect: structure and integration.
   - Expert: feasibility and risk.
   - Reviewer-opus: code quality and maintainability.
4. **Draft plan (planner-opus)**
   - Use `plan-template.md`.
   - Include migration/cutover and rollback strategy.
5. **Stress-test plan**
   - Resolve conflicts between perspectives.
   - Tighten decisions; remove TBD.
6. **Iterate until stable**
   - Plan passes `plan-quality-checklist.md`.
7. **Finalize**
   - Save to `{epic_path}/artifacts/plan.md`.

## Iteration Rules

- Plan for 3-5 iterations depending on risk.
- Stop when plan delta is small (<10%) and no concerns remain.

## Deliverables

- `artifacts/plan.md` (execution-ready).
- Optional supporting artifacts (architecture, risk notes) if they help.
