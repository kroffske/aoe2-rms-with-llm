# Workflow: Standard Planning

Use for well-scoped tasks with moderate complexity.

## Steps

1. **Clarify + lock scope**
   - Confirm requirements, constraints, and out-of-scope items.
2. **Draft plan (planner-opus)**
   - Use `plan-template.md`.
   - Include file-level changes, decisions, tests, and migrations.
3. **Parallel review**
   - Architect + expert + reviewer-opus.
4. **Resolve questions**
   - Ask user only for decisions that cannot be locked internally.
   - Update plan and re-run checklist.
5. **Finalize**
   - Plan passes `plan-quality-checklist.md`.
   - Save to `{epic_path}/artifacts/plan.md`.

## Iteration Rules

- Minimum 2 iterations unless the task is trivial and the user confirms.
- Stop when plan delta is small (<10%) and no concerns remain.

## Deliverables

- `artifacts/plan.md` (execution-ready, no TBD).
