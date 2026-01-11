# Workflow: Planning with Research

Use when feasibility is unclear, external investigation is required, or user explicitly requests research.

## Steps

1. **Clarify + lock scope**
   - Identify the research questions that block planning.
2. **Run research**
   - Use `@.claude/skills/research/SKILL.md`.
   - Produce `docs/research/<topic>/README.md`.
3. **Decide based on research**
   - Convert findings into locked decisions.
4. **Draft plan (planner-opus)**
   - Use `plan-template.md`.
   - Link the research report in the plan.
5. **Review + refine**
   - Architect + expert + reviewer-opus.
6. **Finalize**
   - Plan passes `plan-quality-checklist.md`.
   - Save to `{epic_path}/artifacts/plan.md`.

## Iteration Rules

- Minimum 2 iterations after research is complete.
- Stop when plan delta is small (<10%) and no concerns remain.

## Deliverables

- Research report at `docs/research/<topic>/README.md`.
- `artifacts/plan.md` referencing the research output.
